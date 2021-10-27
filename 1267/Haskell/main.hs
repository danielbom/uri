import Data.List


groupCases :: [[Int]] -> [[[Int]]]
groupCases ([_, n]:xs) = ys:groupCases rest
    where (ys, rest) = splitAt n xs
groupCases _ = []

showPresence True = "yes"
showPresence False = "no"

main = interact
    $ unlines
    . map (showPresence . any (all (==1)) . transpose)
    . takeWhile (not . null)
    . groupCases
    . map (map read . words)
    . lines

