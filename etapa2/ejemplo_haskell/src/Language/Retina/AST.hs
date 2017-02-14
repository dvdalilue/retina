module Language.Retina.AST where

import Language.Retina.Lexeme
import Language.Retina.Token

type Identifier = Lexeme Token
type LiteralNumber = Lexeme Token

data Program = Program [Instruction]
    deriving (Show)

data Function =
    Function       Identifier [Parameter] [Instruction] |
    FunctionR Type Identifier [Parameter] [Instruction]
    deriving(Show)

data Parameter = Parameter Type Identifier 
    deriving(Show)

data Instruction =
    FreeExpression  Expression                                              |
    Assignment      Identifier    Expression                                |
    ConditionalIf   Expression    [Instruction]                             |
    ConditionalElse Expression    [Instruction] [Instruction]               |
    WhileLoop       Expression    [Instruction]                             |
    ForLoop         Identifier    Expression    Expression    [Instruction] |
    RepeatLoop      Expression    [Instruction]                             |
    Block           [Declaration] [Instruction]                             |
    Return          Expression                                              |
    Read            Identifier                                              |
    Write           [Writable]                                             |
    WriteLn         [Writable]
    deriving (Show)

data Writable =
    WritableString (Lexeme Token) |
    WritableExpression Expression
    deriving(Show)

data Declaration =
    Declaration Type [Identifier] |
    InitializeDeclaration Type Identifier Expression
    deriving (Show)

data Type = 
    NumberType |
    BooleanType
    deriving (Show)

data Expression = 
    ExpFalse                                                       |
    ExpTrue                                                        |
    FunctionCall      { name :: Identifier, args :: [Expression] } |
    ExpVariable       { variable :: Identifier  }                  |
    ExpNumber         { number :: LiteralNumber }                  |
    ExpNot            { operand :: Expression   }                  |
    ExpNeg            { operand :: Expression   }                  |
    ExpAnd            { loperand, roperand :: Expression }         |
    ExpOr             { loperand, roperand :: Expression }         |
    ExpEq             { loperand, roperand :: Expression }         |
    ExpNeq            { loperand, roperand :: Expression }         |
    ExpLess           { loperand, roperand :: Expression }         |
    ExpGreater        { loperand, roperand :: Expression }         |
    ExpLessEq         { loperand, roperand :: Expression }         |
    ExpGreaterEq      { loperand, roperand :: Expression }         |
    ExpAddition       { loperand, roperand :: Expression }         |
    ExpSubstraction   { loperand, roperand :: Expression }         |
    ExpMultiplication { loperand, roperand :: Expression }         |
    ExpDivision       { loperand, roperand :: Expression }         |
    ExpRemainder      { loperand, roperand :: Expression }         |
    ExpIntDivision    { loperand, roperand :: Expression }         |
    ExpIntRemainder   { loperand, roperand :: Expression }
    deriving(Show)