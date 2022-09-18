
fib :: [Integer]
fib = 0:1:zipWith (+) fib (tail fib)

main = interact (unlines . map (unwords . map show . flip take fib . read) . lines)

