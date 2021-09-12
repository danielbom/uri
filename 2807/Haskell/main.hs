-- https://www.urionlinejudge.com.br/judge/en/problems/view/2807

fib = 1 : 1 : zipWith (+) fib (tail fib)

main = interact (unlines . map (unwords . map show . reverse . (`take` fib) . read) . lines)
