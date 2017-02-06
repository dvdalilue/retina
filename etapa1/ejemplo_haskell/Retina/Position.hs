module Retina.Position(
    Position(..),
    origin
) where

data Position = Position {row :: Int, column :: Int}

instance Show Position where
    show p = "line " ++ show (row p) ++ ", column " ++ show (column p)

origin :: Position
origin = Position 0 0