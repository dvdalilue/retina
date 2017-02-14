module Main where

import Retina.Lexer
import Retina.Parser
import System.Exit

lexicalAnalysis :: String -> IO [Lexeme Token]
lexicalAnalysis s =
    case runAlex' s (loop []) of
        Right ts -> return ts
        where
            loop ls = do
                token@(Lexeme td tp) <- alexMonadScan
                case td of
                    TkEOF -> return ls
                    otherwise -> do
                        loop $! (token:ls)

lexicalErrorChecker :: [Lexeme Token] -> IO (Either [Lexeme Token] [Lexeme Token])
lexicalErrorChecker ts = return tokens -- mapM_ print $ reverse tokens
    where
        errors = filter checkErrors ts
        tokens = if null errors
            then Left $ reverse ts
            else Right $ reverse errors

        checkErrors t =
            case t of 
                (Lexeme (TkError _) _)     -> True
                (Lexeme (TkBadString _) _) -> True
                otherwise                  -> False

parseProgram :: Either [Lexeme Token] [Lexeme Token] -> IO ()
parseProgram ts =
    case ts of 
        Left tokens -> do
            ast <- parse tokens `catch` handler 
            print ast
        Right errors -> mapM_ print errors
        where
            handler (SyntacticError s) = putStrLn s >> exitFailure

main = do
    getContents >>=
        lexicalAnalysis >>=
            lexicalErrorChecker >>=
                parseProgram