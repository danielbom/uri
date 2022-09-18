-- https://www.urionlinejudge.com.br/judge/en/problems/view/1149

sum1N n = (n * (n + 1)) `div` 2

sumOf (x:y:zs) = sum1N (y + x - 1) - sum1N (x - 1)
sumOf _ = 0

main = interact ((++ "\n") . show . sumOf . filter (> 0) . map read . words)
