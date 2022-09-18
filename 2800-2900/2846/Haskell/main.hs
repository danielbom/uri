-- https://www.urionlinejudge.com.br/judge/en/problems/view/2846

fib = 1 : 1 : zipWith (+) fib (tail fib)

notfib = concat $ zipWith range fib (tail fib)
  where range x y = [(x + 1)..(y - 1)]

main = interact (unlines . map (show . (!!) notfib . flip (-) 1 . read) . lines)
