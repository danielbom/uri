

isPrime n = n < 4 || isPrime'
    where k = floor $ sqrt $ fromIntegral n
          isPrime' = all ((/= 0) . mod n) $ takeWhile (<=k) primes 

primes :: [Integer]
primes = 2:3:filter isPrime (intercale [5,11..] [7,13..])
    where intercale (x:xs) ys = x:intercale ys xs

showPrime n
    | isPrime n = show n ++ " eh primo"
    | otherwise = show n ++ " nao eh primo"

main = interact 
    $ unlines 
    . map (showPrime . read)
    . tail
    . lines

