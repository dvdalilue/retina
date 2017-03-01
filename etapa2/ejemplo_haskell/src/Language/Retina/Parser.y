{
{-# LANGUAGE DeriveDataTypeable #-}

module Language.Retina.Parser(
    parse,
    SyntacticError(..),
    module Control.Exception,
    module Language.Retina.AST
) where

import Language.Retina.AST
import Language.Retina.Lexer
import Language.Retina.Lexeme
import Control.Exception
import Data.Typeable

}

%name parse
%monad { IO }
-- %lexer { lexwrap } { Lexeme TkEOF _ }
%tokentype { Lexeme Token }
%error { parseError }

%token
    "program"  { Lexeme TkProgram _           }
    "with"     { Lexeme TkWith _              }
    "do"       { Lexeme TkDo _                }
    "end"      { Lexeme TkEnd _               }

    "func"     { Lexeme TkFunction _          }
    "begin"    { Lexeme TkBegin _             }
    "return"   { Lexeme TkReturn _            }
    "number"   { Lexeme TkNumber _            }
    "boolean"  { Lexeme TkBoolean _           }
    "true"     { Lexeme TkLiteralTrue _       }
    "false"    { Lexeme TkLiteralFalse _      }
    
    "if"       { Lexeme TkIf _                }
    "then"     { Lexeme TkThen _              }
    "else"     { Lexeme TkElse _              }
    "while"    { Lexeme TkWhile _             }
    "for"      { Lexeme TkFor _               }
    "from"     { Lexeme TkFrom _              }
    "to"       { Lexeme TkTo _                }
    "repeat"   { Lexeme TkRepeat _            }
    "times"    { Lexeme TkTimes _             }

    "read"     { Lexeme TkRead _              }
    "write"    { Lexeme TkWrite _             }
    "writeln"  { Lexeme TkWriteLn _           }

    string     { Lexeme (TkLiteralString _) _ }
    identifier { Lexeme (TkIdent _) _         }
    number     { Lexeme (TkLiteralNumber _) _ }

    "->"       { Lexeme TkArrow _             }

    "="        { Lexeme TkAssign _            }
    ","        { Lexeme TkComma _             }
    ";"        { Lexeme TkSemicolon _         }
    "("        { Lexeme TkOpenParen _         }
    ")"        { Lexeme TkCloseParen _        }
    
    "not"      { Lexeme TkNot _               }
    "and"      { Lexeme TkAnd _               }
    "or"       { Lexeme TkOr _                }
    
    "=="       { Lexeme TkEqual _             }
    "/="       { Lexeme TkUnequal _           }
    "<"        { Lexeme TkLess _              }
    ">"        { Lexeme TkGreat _             }
    "<="       { Lexeme TkLesseq _            }
    ">="       { Lexeme TkGreateq _           }
    
    "+"        { Lexeme TkPlus _              }
    "-"        { Lexeme TkMinus _             }
    "*"        { Lexeme TkStar _              }
    "/"        { Lexeme TkSlash _             }
    "%"        { Lexeme TkPercent _           }
    "div"      { Lexeme TkDiv _               }
    "mod"      { Lexeme TkMod _               }

%left "or"
%left "and"
%nonassoc "==" "/=" "<" ">" "<=" ">="
%right "not"

%left "+" "-"
%left "*" "/" "%" "div" "mod"
%right uminus

%%

Program: Functions "program" Instructions "end" ";" { Program (reverse $1) $3 }

Functions:                        { []    }
         | Functions Function ";" { $2:$1 }

Function: "func" identifier "(" Parameters ")" "begin" Instructions "end"           { Function     $2 (reverse $4) $7 }
        | "func" identifier "(" Parameters ")" "->" Type "begin" Instructions "end" { FunctionR $7 $2 (reverse $4) $9 }

Parameters:                   { [] }
          | ParameterSequence { $1 }

ParameterSequence: Parameter                       { [$1]  }
                 | ParameterSequence "," Parameter { $3:$1 }

Parameter: Type identifier { Parameter $1 $2 }

Instructions:                              { []    }
            | Instructions Instruction ";" { $2:$1 }

Instruction: identifier "(" Args ")"                                                    { ProcedureCall $1 $3                          }
           | identifier "=" Expression                                                  { Assignment $1 $3                             }
           | "if" Expression "then" Instructions "end"                                  { ConditionalIf $2 (reverse $4)                }
           | "if" Expression "then" Instructions "else" Instructions "end"              { ConditionalElse $2 (reverse $4) (reverse $6) }
           | "while" Expression "do" Instructions "end"                                 { WhileLoop $2 (reverse $4)                    }
           | "for" identifier "from" Expression "to" Expression "do" Instructions "end" { ForLoop $2 $4 $6 (reverse $8)                }
           | "repeat" Expression "times" Instructions "end"                             { RepeatLoop $2 (reverse $4)                   }
           | "with" Declarations "do" Instructions "end"                                { Block (reverse $2) $4                        }
           | "return" Expression                                                        { Return $2                                    }
           | "read" identifier                                                          { Read $2                                      }
           | "write" Writables                                                          { Write (reverse $2)                           }
           | "writeln" Writables                                                        { WriteLn (reverse $2)                         }

Declarations:                              { []    }
            | Declarations Declaration ";" { $2:$1 }

Declaration: Type IdentifierList            { Declaration $1 (reverse $2)    }
           | Type identifier "=" Expression { InitializeDeclaration $1 $2 $4 }

Type: "number"  { NumberType  }
    | "boolean" { BooleanType }

IdentifierList: identifier                    { [$1]  }
              | IdentifierList "," identifier { $3:$1 }

Writables: Writable                { [$1]  }
         | Writables "," Writable { $3:$1 }

Writable: string     { WritableString     $1 }
        | Expression { WritableExpression $1 }

Expression : "(" Expression ")"          { $2                      }
           | identifier "(" Args ")"     { FunctionCall $1 $3      }
           | "true"                      { ExpTrue                 }
           | "false"                     { ExpFalse                }
           | number                      { ExpNumber         $1    }
           | identifier                  { ExpVariable       $1    }
           | "not" Expression            { ExpNot            $2    }
           | "-" Expression %prec uminus { ExpNeg            $2    }
           | Expression "and" Expression { ExpAnd            $1 $3 }
           | Expression "or"  Expression { ExpOr             $1 $3 }
           | Expression "=="  Expression { ExpEq             $1 $3 }
           | Expression "/="  Expression { ExpNeq            $1 $3 }
           | Expression "<"   Expression { ExpLess           $1 $3 }
           | Expression ">"   Expression { ExpGreater        $1 $3 }
           | Expression "<="  Expression { ExpLessEq         $1 $3 }
           | Expression ">="  Expression { ExpGreaterEq      $1 $3 }
           | Expression "+"   Expression { ExpAddition       $1 $3 }
           | Expression "-"   Expression { ExpSubstraction   $1 $3 }
           | Expression "*"   Expression { ExpMultiplication $1 $3 }
           | Expression "/"   Expression { ExpDivision       $1 $3 }
           | Expression "%"   Expression { ExpRemainder      $1 $3 }
           | Expression "div" Expression { ExpIntDivision    $1 $3 }
           | Expression "mod" Expression { ExpIntRemainder   $1 $3 }

Args:             { [] }
    | ArgSequence { $1 }

ArgSequence: Expression          { [$1]  }
           | ArgSequence "," Expression { $3:$1 }

{

-- lexwrap :: (Lexeme Token -> Alex a) -> Alex a
-- lexwrap = (alexMonadScan >>=)

data SyntacticError = SyntacticError String
    deriving (Show, Typeable)

instance Exception SyntacticError

parseError :: [Lexeme Token] -> IO a
parseError [] = throw $ SyntacticError "invalid program"
parseError ts = throw $ SyntacticError $ "Unexpected token: " ++ show (head ts)

}