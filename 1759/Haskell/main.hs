-- https://www.urionlinejudge.com.br/judge/en/problems/view/1435

main = do
  n <- readLn 
  putStrLn $ (concatMap (const "Ho ") [1..n - 1]) ++ "Ho!" 
