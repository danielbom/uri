-- https://www.urionlinejudge.com.br/judge/en/problems/view/1164

isPerfect x = x == sum (filter (\y -> x `mod` y == 0) [1..x - 1])

isPerfect' x = x ++ perfect ++ " eh perfeito"
  where perfect = if isPerfect (read x) then "" else " nao"

main = interact (unlines . map isPerfect' . tail . lines)