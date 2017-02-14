module Language.Retina.Lexeme(
    Lexeme(..),
    module Language.Retina.Position
) where

import Language.Retina.Position

data Lexeme a = Lexeme {lexemeData :: a, lexemePosition :: Position}

instance Show a => Show (Lexeme a) where
    show l = show (lexemePosition l) ++ ": " ++ show (lexemeData l)