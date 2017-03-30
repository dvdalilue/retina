data Token =
    TkProgram    (Int,Int) |
    TkWith       (Int,Int) |
    TkDo         (Int,Int) |
    TkEnd        (Int,Int) |
    TkIf         (Int,Int) |
    TkThen       (Int,Int) |
    TkElse       (Int,Int) |
    TkFor        (Int,Int) |
    TkFrom       (Int,Int) |
    TkTo         (Int,Int) |
    TkRepeat     (Int,Int) |
    TkTimes      (Int,Int) |
    TkNumber     (Int,Int) |
    TkBoolean    (Int,Int) |
    TkNot        (Int,Int) |
    TkAnd        (Int,Int) |
    TkOr         (Int,Int) |
    TkEqual      (Int,Int) |
    TkUnequal    (Int,Int) |
    TkLesseq     (Int,Int) |
    TkGreateq    (Int,Int) |
    TkGreat      (Int,Int) |
    TkLess       (Int,Int) |
    TkMinus      (Int,Int) |
    TkPlus       (Int,Int) |
    TkStar       (Int,Int) |
    TkSlash      (Int,Int) |
    TkPercent    (Int,Int) |
    TkSemicolon  (Int,Int) 

instance Show Token where
    show t = case t of
        TkProgram p   -> (showPos p) ++ " Token found: 'program'"
        TkWith p      -> (showPos p) ++ " Token found: 'wtih'"
        TkDo p        -> (showPos p) ++ " Token found: 'do'"
        TkEnd p       -> (showPos p) ++ " Token found: 'end'"
        TkIf p        -> (showPos p) ++ " Token found: 'if'"
        TkThen p      -> (showPos p) ++ " Token found: 'then'"
        TkElse p      -> (showPos p) ++ " Token found: 'else'"
        TkFor p       -> (showPos p) ++ " Token found: 'for'"
        TkFrom p      -> (showPos p) ++ " Token found: 'from'"
        TkTo p        -> (showPos p) ++ " Token found: 'to'"
        TkRepeat p    -> (showPos p) ++ " Token found: 'repeat'"
        TkTimes p     -> (showPos p) ++ " Token found: 'times'"
        TkNumber p    -> (showPos p) ++ " Token found: 'number'"
        TkBoolean p   -> (showPos p) ++ " Token found: 'boolean'"
        TkNot p       -> (showPos p) ++ " Token found: 'not'"
        TkAnd p       -> (showPos p) ++ " Token found: 'and'"
        TkOr p        -> (showPos p) ++ " Token found: 'or'"
        TkEqual p     -> (showPos p) ++ " Token found: '=='"
        TkUnequal p   -> (showPos p) ++ " Token found: '/='"
        TkLesseq p    -> (showPos p) ++ " Token found: '<='"
        TkGreateq p   -> (showPos p) ++ " Token found: '>='"
        TkGreat p     -> (showPos p) ++ " Token found: '>'"
        TkLess p      -> (showPos p) ++ " Token found: '<'"
        TkMinus p     -> (showPos p) ++ " Token found: '-'"
        TkPlus p      -> (showPos p) ++ " Token found: '+'"
        TkStar p      -> (showPos p) ++ " Token found: '*'"
        TkSlash p     -> (showPos p) ++ " Token found: '/'"
        TkPercent p   -> (showPos p) ++ " Token found: '%'"
        TkSemicolon p -> (showPos p) ++ " Token found: ';'"
        where
            showPos (l,c) = "line: " ++ (show l) ++ ", colunm: " ++ (show c) ++ "."