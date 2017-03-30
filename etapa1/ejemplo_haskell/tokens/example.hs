data Token =
    TkProgram   |
    TkWith      |
    TkDo        |
    TkEnd       |
    TkIf        |
    TkThen      |
    TkElse      |
    TkFor       |
    TkFrom      |
    TkTo        |
    TkRepeat    |
    TkTimes     |
    TkNumber    |
    TkBoolean   |
    TkNot       |
    TkAnd       |
    TkOr        |
    TkEqual     |
    TkUnequal   |
    TkLesseq    |
    TkGreateq   |
    TkGreat     |
    TkLess      |
    TkMinus     |
    TkPlus      |
    TkStar      |
    TkSlash     |
    TkPercent   |
    TkSemicolon

instance Show Token where
    show t = case t of
        TkProgram          -> "'program'"
        TkWith             -> "'wtih'"
        TkDo               -> "'do'"
        TkEnd              -> "'end'"
        TkIf               -> "'if'"
        TkThen             -> "'then'"
        TkElse             -> "'else'"
        TkFor              -> "'for'"
        TkFrom             -> "'from'"
        TkTo               -> "'to'"
        TkRepeat           -> "'repeat'"
        TkTimes            -> "'times'"
        TkNumber           -> "'number'"
        TkBoolean          -> "'boolean'"
        TkNot              -> "'not'"
        TkAnd              -> "'and'"
        TkOr               -> "'or'"
        TkEqual            -> "'=='"
        TkUnequal          -> "'/='"
        TkLesseq           -> "'<='"
        TkGreateq          -> "'>='"
        TkGreat            -> "'>'"
        TkLess             -> "'<'"
        TkMinus            -> "'-'"
        TkPlus             -> "'+'"
        TkStar             -> "'*'"
        TkSlash            -> "'/'"
        TkPercent          -> "'%'"
        TkSemicolon        -> "';'"

data Word = Word Token (Int,Int)


instance Show Word where
    show (Word t p) = (showPos p) ++ (show t)
        where
            showPos (l,c) = "line: " ++ (show l) ++ ", colunm: " ++ (show c) ++ ". Token found: "