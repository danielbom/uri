-- https://www.beecrowd.com.br/judge/en/problems/view/1589

main = interact $
  unlines .
  map (show . sum . map read . words) .
  tail .
  lines
