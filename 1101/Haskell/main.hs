import Data.List

sumN :: Integer -> Integer
sumN n = (n * (n + 1)) `div` 2

sumOf x y = sumN x - sumN (y - 1)

numbersSum [x, y] =
    let numbers = unwords . map show $ [x..y]
    in  numbers ++ " Sum=" ++ show (sumOf y x)

main = interact $ unlines 
    . map numbersSum
    . takeWhile (\xs -> (length xs == 2) && all (0<) xs)
    . map (sort . map read . words)
    . lines

