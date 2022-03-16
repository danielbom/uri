-- https://www.beecrowd.com.br/judge/en/problems/view/1866

main = interact
  $ unlines
  . map (show . (`mod` 2) . read)
  . tail
  . lines
