-- https://www.urionlinejudge.com.br/judge/en/problems/view/3091
odds :: Integer -> [Integer]
odds n = [1,3..n]

main = do
  n <- readLn
  putStr . unlines . map show . odds $ n 
