-- https://www.urionlinejudge.com.br/judge/en/problems/view/1435


createMatrix :: Int -> [String]
createMatrix n = map (\i -> map (\j -> chAt i j) [1..n]) [1..n]
  where chAt i j
          | k == j = '2'
          | i == j = '1'
          | otherwise = '3'
          where k = n - i + 1

main = interact $ concat . map (unlines . createMatrix) . map read . lines
