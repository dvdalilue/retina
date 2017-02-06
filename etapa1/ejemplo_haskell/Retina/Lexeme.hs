module Retina.Lexeme(
    Lexeme(..),
    module  Retina.Position
) where

import Retina.Position

data Lexeme a = Lexeme {lexemeData :: a, lexemePosition :: Position}

instance Show a => Show (Lexeme a) where
    show l = show (lexemePosition l) ++ ": " ++ show (lexemeData l)