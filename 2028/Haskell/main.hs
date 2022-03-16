-- https://www.beecrowd.com.br/judge/en/problems/view/2028
sumOf :: Int -> Int
sumOf n = go 1 1
  where 
    go count s =
      if count > n
      then s
      else go (count+1) (s+count)

fibonacciSequence :: [Int]
fibonacciSequence = 0:go 0 0
  where 
    go current count =
      if current == count
      then go (current + 1) 0
      else current:go current (count + 1)

takeFibonacciSequence :: Int -> [Int]
takeFibonacciSequence n =
  takeWhile (<=n) $ fibonacciSequence

sequenceOfSequence :: Int -> Int -> String
sequenceOfSequence testCase n =
  unlines 
    [ "Caso " ++ show testCase ++ ": " ++ show numbersCount ++ " numero" ++ plural
    , unwords . map show . takeFibonacciSequence $ n
    ]
  where
    numbersCount = sumOf n
    plural = if numbersCount > 1 then "s" else ""

main :: IO ()
main = interact
  $ unlines
  . zipWith sequenceOfSequence [1..]
  . map read
  . lines
