parse :: String -> (Int, Int)
parse line = (a, b)
    where [a, b] = map read $ words line

bills :: [Int]
bills = [2, 5, 10, 20, 50, 100]

computePairs :: [Int] -> [Int]
computePairs [] = []
computePairs [x] = []
computePairs xs = go xs ++ computePairs (tail xs)
    where go (x:y:xs) = (x + y):go (x:xs)
          go _ = []

check :: (Int, Int) -> Bool
check (buyPrice, pricePaid) = change `elem` possibleBills
    where change = pricePaid - buyPrice
          possibleBills = computePairs bills

answer :: Bool -> String
answer True = "possible"
answer False = "impossible"

main :: IO ()
main = interact
    $ unlines
    . map (answer . check)
    . takeWhile ((/=0) . fst)
    . map parse
    . lines
