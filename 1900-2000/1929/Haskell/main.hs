-- https://www.beecrowd.com.br/judge/en/problems/view/1914

import Data.List as L

readInts :: String -> [Integer]
readInts = map read . words

permutationWithoutRepetition :: Int -> [a] -> [[a]]
permutationWithoutRepetition k xs = go 0 [] xs
    where go :: Int -> [a] -> [a] -> [[a]]
          go _ _ [] = []
          go count ys xs
            | count + 1 == k = map (reverse . (:ys)) xs
            | otherwise = concatMap (\xs' -> go (count + 1) (head xs':ys) (tail xs')) (init $ L.tails xs)

isTriangleSides :: (Real a) => [a] -> Bool
isTriangleSides xs = x + y > z
    where [x, y, z] = L.sort xs

main :: IO ()
main = do
    sides <- fmap readInts getLine
    let triangleSides = permutationWithoutRepetition 3 sides
    if not . null . filter isTriangleSides $ triangleSides
    then putStrLn "S"
    else putStrLn "N"

