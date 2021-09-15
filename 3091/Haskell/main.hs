-- https://www.urionlinejudge.com.br/judge/en/problems/view/2846

main = do 
  x <- readLn
  y <- readLn
  print $ x `mod` y
