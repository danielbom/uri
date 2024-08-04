import Data.List (foldl')

parse :: String -> [Int]
parse = map read . words  

countMultiplesOf :: [Int] -> Int -> Int
countMultiplesOf xs y = foldl' (\acc x -> if x `mod` y == 0 then acc + 1 else acc) 0 xs

process :: [Int] -> [(Int, Int)]
process xs = zip numbers $ map (countMultiplesOf xs) numbers
    where numbers = [2, 3, 4, 5]

display :: [(Int, Int)] -> String
display = unlines . map (\(y, count) -> show count ++ " Multiplo(s) de " ++ show y)

main :: IO ()
main = do
    _ <- getLine
    line <- getLine
    putStr . display . process . parse $ line
