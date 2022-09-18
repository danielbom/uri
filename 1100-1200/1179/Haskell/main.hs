import Data.List

data ListT = Even [Int] | Odd [Int]
    deriving (Show)

data Model = Model 
    { countEven :: Int
    , listEven :: [Int]
    , countOdd :: Int
    , listOdd :: [Int]
    , output :: [ListT]
    }
    deriving (Show)

initialState = Model 0 [] 0 [] []

addValue :: Model -> Int -> Model
addValue m x  
    | even x    = updateOutput $ m { countEven = countEven m + 1, listEven = x:listEven m }
    | otherwise = updateOutput $ m { countOdd = countOdd m + 1, listOdd = x:listOdd m }

updateOutput :: Model -> Model
updateOutput m 
    | countEven m == 5 = m { output = (Even $ listEven m):output m, listEven = [], countEven = 0 }
    | countOdd m  == 5 = m { output = (Odd $ listOdd m):output m,   listOdd = [],  countOdd = 0 }
    | otherwise        = m

finishOutput :: Model -> [ListT]
finishOutput m = Even (listEven m):Odd (listOdd m):output m

mapListT :: ListT -> [String]
mapListT (Odd xs) = 
    zipWith (\i x -> "impar[" ++ show i ++ "] = " ++ show x) [0..] (reverse xs)
mapListT (Even xs) = 
    zipWith (\i x -> "par[" ++ show i ++ "] = " ++ show x) [0..] (reverse xs)

showListT :: [[String]] -> ListT -> [[String]]
showListT ys lsT = mapListT lsT:ys

main = interact 
    $ unlines
    . concat
    . foldl' showListT []
    . finishOutput
    . foldl' addValue initialState
    . map read
    . lines
