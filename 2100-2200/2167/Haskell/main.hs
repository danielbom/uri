parse :: String -> [Int]
parse = map read . words

find :: [Int] -> Int
find xs = case indexFalls of
        [] -> 0
        ((index, _):_) -> index
    where falls = zipWith (>) xs (tail xs)
          indexFalls = filter snd $ zip [2..] falls

main :: IO ()
main = do
    _ <- getLine
    line <- getLine
    putStrLn $ show $ find $ parse line
