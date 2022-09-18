import Data.List

data Mov = One | Two | Three

moviment x One = case x of
    1 -> 2
    2 -> 1
    _ -> x
moviment x Two = case x of
    2 -> 3
    3 -> 2
    _ -> x
moviment x Three = case x of 
    1 -> 3
    3 -> 1
    _ -> x

makeMoves (x:xs) = toPosition $ foldl' moviment firstPosition $ map toMove xs 
    where
      toPosition :: Integer -> String
      toPosition y = case y of
        1 -> "A"
        2 -> "B"
        3 -> "C"
        _ -> error "Unreachable"
      toMove m = case m of
        "1" -> One
        "2" -> Two
        "3" -> Three
        _   -> error $ "Invalid moviment: " ++ m
      firstPosition = case x of
        "A" -> 1
        "B" -> 2
        "C" -> 3
        _   -> error $ "Invalid first position: " ++ x


main = interact $ (++"\n") . makeMoves . tail . lines

