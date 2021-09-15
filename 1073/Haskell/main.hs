-- https://www.urionlinejudge.com.br/judge/en/problems/view/1009

out x = show x ++ "^2 = " ++ show (x * x)

main = do
  x <- readLn
  putStr $ unlines $ map out [2,4..x]
