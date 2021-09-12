-- https://www.urionlinejudge.com.br/judge/en/problems/view/1044

fib = 0 : 1 : zipWith (+) fib (tail fib)

showFib n = "Fib(" ++ show n ++ ") = " ++ show (fib !! n)

main = interact (unlines . map (showFib . read) . tail . lines)
