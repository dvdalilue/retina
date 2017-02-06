module Main where

import Retina.Lexer

loop :: [Lexeme Token] -> Alex [Lexeme Token]
loop ls = do
    token@(Lexeme td tp) <- alexMonadScan
    case td of
        TkEOF -> return ls
        otherwise -> do
            loop $! (token:ls)

scanner' :: String -> IO [Lexeme Token]
scanner' s =
    case runAlex' s (loop []) of
        Right ts -> return ts

printTokens :: [Lexeme Token] -> IO ()
printTokens ts = mapM_ print $ reverse tokens
    where
        errors = checkErrors ts
        tokens = if null errors 
            then ts
            else errors

        checkErrors [] = []
        checkErrors (t:ts) =
            case t of 
                (Lexeme (TkError _) _)     -> t:(checkErrors ts)
                (Lexeme (TkBadString _) _) -> t:(checkErrors ts)
                otherwise                  -> (checkErrors ts)

main = do
    getContents >>=
        scanner' >>=
            printTokens