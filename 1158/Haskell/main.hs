-- https://www.beecrowd.com.br/judge/en/problems/view/1158

nextOdd x 
  | odd x     = x
  | otherwise = x + 1

sumOfOddNumbers :: [Int] -> Int
sumOfOddNumbers [x, y] = sum 
  . take y 
  . iterate (+2)
  $ nextOdd x
sumOfOddNumbers _ = 0

main :: IO ()
main = interact 
  $ unlines
  . map (show . sumOfOddNumbers . map read . words)
  . tail
  . lines
