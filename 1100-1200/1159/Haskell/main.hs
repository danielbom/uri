-- https://www.beecrowd.com.br/judge/en/problems/view/1159

nextEven x
  | even x    = x
  | otherwise = x + 1

sumOfEvenNumbers :: Int -> Int
sumOfEvenNumbers x = sum
  . take 5
  . iterate (+2)
  $ nextEven x

main :: IO ()
main = interact
  $ unlines
  . map (show . sumOfEvenNumbers)
  . takeWhile (/= 0)
  . map read
  . lines
