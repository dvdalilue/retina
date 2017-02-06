module Retina.Token(
    Token(..)
) where

data Token =
    -- Basic tokens
    TkProgram |
    TkWith |
    TkDo |
    TkSemicolon |
    TkEnd |
    -- Control structures
    TkIf |
    TkThen |
    TkElse |
    TkFor |
    TkFrom |
    TkTo |
    TkRepeat |
    TkTimes |
    -- Types
    TkNumber |
    TkBoolean |
    -- Logic operators
    TkNot |
    TkAnd |
    TkOr |
    -- Compartion operators
    TkEqual |
    TkUnequal |
    TkLess |
    TkGreat |
    TkLesseq |
    TkGreateq |
    -- Arithmetic operators
    TkMinus |
    TkPlus |
    TkStar |
    TkSlash |
    TkPercent |
    TkDiv |
    TkMod |
    -- I/O
    TkRead |
    TkWrite |
    -- Assignation
    TkAssign |
    -- Literal
    TkLiteralString { string :: String } |
    TkLiteralNumber { number :: Double } |
    TkLiteralTrue |
    TkLiteralFalse |
    -- Function
    TkFunction |
    TkOpenParen |
    TkCloseParen |
    TkBegin |
    TkArrow |
    TkReturn |
    -- Identifier
    TkIdent { value :: String } |
    -- Support
    TkEOF |
    TkError { error :: String } |
    TkBadString { badString :: String }

instance Show Token where
    show t = case t of
        TkProgram          -> "reserved word: 'program'"
        TkWith             -> "reserved word: 'wtih'"
        TkDo               -> "reserved word: 'do'"
        TkSemicolon        -> "symbol: ';'"
        TkEnd              -> "reserved word: 'end'"
        TkIf               -> "reserved word: 'if'"
        TkThen             -> "reserved word: 'then'"
        TkElse             -> "reserved word: 'else'"
        TkFor              -> "reserved word: 'for'"
        TkFrom             -> "reserved word: 'from'"
        TkTo               -> "reserved word: 'to'"
        TkRepeat           -> "reserved word: 'repeat'"
        TkTimes            -> "reserved word: 'times'"
        TkNumber           -> "reserved word: 'number'"
        TkBoolean          -> "reserved word: 'boolean'"
        TkNot              -> "reserved word: 'not'"
        TkAnd              -> "reserved word: 'and'"
        TkOr               -> "reserved word: 'or'"
        TkEqual            -> "symbol: '=='"
        TkUnequal          -> "symbol: '/='"
        TkLess             -> "symbol: '<'"
        TkGreat            -> "symbol: '>'"
        TkLesseq           -> "symbol: '<='"
        TkGreateq          -> "symbol: '>='"
        TkMinus            -> "symbol: '-'"
        TkPlus             -> "symbol: '+'"
        TkStar             -> "symbol: '*'"
        TkSlash            -> "symbol: '/'"
        TkPercent          -> "symbol: '%'"
        TkDiv              -> "reserved word: 'div'"
        TkMod              -> "reserved word: 'mod'"
        TkRead             -> "reserved word: 'read'"
        TkWrite            -> "reserved word: 'write'"
        TkAssign           -> "symbol: '='"
        TkLiteralString s  -> "string literal: '" ++ s ++ "'"
        TkLiteralNumber n  -> "number literal: '" ++ (showNumber n) ++ "'"
        TkLiteralTrue      -> "boolean literal: 'true'"
        TkLiteralFalse     -> "boolean literal: 'false'"
        TkFunction         -> "reserved word: 'func'"
        TkOpenParen        -> "symbol: '('"
        TkCloseParen       -> "symbol: ')'"
        TkBegin            -> "reserved word: 'begin'"
        TkArrow            -> "symbol: '->'"
        TkReturn           -> "reserved word: 'return'"
        TkIdent v          -> "Identifier: '" ++ v ++ "'"
        TkEOF              -> "EOF"
        TkError e          -> "lexical error: '" ++ e ++ "'"
        TkBadString bs     -> "bad formed string: '" ++ bs ++ "'"
        where
            isInt x = x == fromInteger (round x)
            showNumber n = if (isInt n) then show (fromInteger (round n)) else show $ n