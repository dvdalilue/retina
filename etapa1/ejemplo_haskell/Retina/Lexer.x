{

module Retina.Lexer(
    Alex(..),
    Token(..),
    Lexeme(..),
    runAlex',
    alexMonadScan
) where

import Retina.Token
import Retina.Lexeme

}

%wrapper "monad"

-- Macro definitions
$whitechar = [\ \s\t\n\r\f\v]

$underscore = \_
$digit  = 0-9
$uppercase = A-Z
$downcase  = a-z
$alpha     = [$downcase $uppercase]

$backslash = ["\\n]

-- Regular expression macros
@inside_string  = ($printable # ["\\] | \\$backslash)
@string         = \"@inside_string*\"
@bad_string     = \"@inside_string*
@space = $whitechar+
@identifier = $downcase [$alpha $digit $underscore]*
@double = $digit+\.$digit+
@number = ($digit+ | @double)

-- Regular expressions & data type correspondences
retina :-
    @space      { skip                         }
    "program"   { mkL (const TkProgram)        }
    "with"      { mkL (const TkWith)           }
    "do"        { mkL (const TkDo)             }
    "end"       { mkL (const TkEnd)            }
    "if"        { mkL (const TkIf)             }
    "then"      { mkL (const TkThen)           }
    "else"      { mkL (const TkElse)           }
    "for"       { mkL (const TkFor)            }
    "from"      { mkL (const TkFrom)           }
    "to"        { mkL (const TkTo)             }
    "repeat"    { mkL (const TkRepeat)         }
    "times"     { mkL (const TkTimes)          }
    "number"    { mkL (const TkNumber)         }
    "boolean"   { mkL (const TkBoolean)        }
    "not"       { mkL (const TkNot)            }
    "and"       { mkL (const TkAnd)            }
    "or"        { mkL (const TkOr)             }
    "div"       { mkL (const TkDiv)            }
    "mod"       { mkL (const TkMod)            }
    "read"      { mkL (const TkRead)           }
    "write"     { mkL (const TkWrite)          }
    "function"  { mkL (const TkFunction)       }
    "begin"     { mkL (const TkBegin)          }
    "return"    { mkL (const TkReturn)         }
    ";"         { mkL (const TkSemicolon)      }
    "=="        { mkL (const TkEqual)          }
    "/="        { mkL (const TkUnequal)        }
    "<"         { mkL (const TkLess)           }
    ">"         { mkL (const TkGreat)          }
    "<="        { mkL (const TkLesseq)         }
    ">="        { mkL (const TkGreateq)        }
    "-"         { mkL (const TkMinus)          }
    "+"         { mkL (const TkPlus)           }
    "*"         { mkL (const TkStar)           }
    "/"         { mkL (const TkSlash)          }
    "%"         { mkL (const TkPercent)        }
    "="         { mkL (const TkAssign)         }
    "("         { mkL (const TkOpenParen)      }
    ")"         { mkL (const TkCloseParen)     }
    "->"        { mkL (const TkArrow)          }
    "true"      { mkL (const TkLiteralTrue)    } 
    "false"     { mkL (const TkLiteralFalse)   } 
    @string     { mkL (TkLiteralString . read) } 
    @number     { mkL (TkLiteralNumber . read) }
    @identifier { mkL TkIdent                  }
    @bad_string { mkL TkBadString              }
    .           { mkL TkError                  }

{

mkL :: (String -> Token) -> AlexInput -> Int -> Alex (Lexeme Token)
mkL t (p,_,_,s) l = return (Lexeme (t $ take l s) (toPosition p))

toPosition :: AlexPosn -> Position
toPosition (AlexPn _ r c) = Position r c

alexEOF = return $ Lexeme TkEOF origin

state :: String -> AlexState
state input = AlexState {
    alex_pos = alexStartPos,
    alex_inp = input,
    alex_chr = '\n',
    alex_bytes = [],
    alex_scd = 0
}

runAlex' :: String -> Alex a -> Either String a
runAlex' input (Alex f) = case f (state input) of
    Left msg -> Left msg
    Right ( _, a ) -> Right a

}
