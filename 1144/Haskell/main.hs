-- https://www.urionlinejudge.com.br/judge/en/problems/view/1144

logicalSequence :: Integer -> [[Integer]]
logicalSequence n = do
  i <- [1..n]
  let i2 = i * i
      i3 = i2 * i
  [[i, i2, i3], [i, i2 + 1, i3 + 1]]

main = interact (unlines . map (unwords . map show) . logicalSequence . read)
