-- https://www.urionlinejudge.com.br/judge/en/problems/view/1044

chunksOf :: Int -> [a] -> [[a]]
chunksOf n xs = go xs
  where
    go [] = []
    go xs = take n xs : go (drop n xs) 

logicalSequence :: Integer -> [Integer]
logicalSequence n = do
  i <- [1..n]
  let i2 = i * i
      i3 = i2 * i
  [i, i2, i3, i, i2 + 1, i3 + 1]

main = do
  n <- getLine
  putStr $ unlines . map unwords . chunksOf 3 . map show . logicalSequence $ read n
