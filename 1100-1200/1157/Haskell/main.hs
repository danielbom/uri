-- https://www.beecrowd.com.br/judge/en/problems/view/1157

divisors :: Integer -> [Integer]
divisors n = filter (\x -> n `mod` x == 0) [1..n]

main :: IO ()
main = do
    x <- getLine
    putStr
      . unlines
      . map show
      . divisors
      . read $ x
