-- https://www.urionlinejudge.com.br/judge/en/problems/view/1435

dropOdd [] = []
dropOdd [x] = [x]
dropOdd (x:y:xs) = y:dropOdd xs

level x 
  | x < 10    = 1
  | x < 20    = 2
  | otherwise = 3

main = interact $ unlines . map (show . level . maximum . map read . words) . dropOdd . lines
