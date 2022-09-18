-- https://www.urionlinejudge.com.br/judge/en/problems/view/1144

chunksOf :: Int -> [a] -> [[a]]
chunksOf n = go
  where go [] = []
        go xs = take n xs : go (drop n xs)

logicalSequence (x:y:zs) = chunksOf x [1..y]
logicalSequence _ = []

main = interact (unlines . map (unwords . map show) . logicalSequence . map read . words)
