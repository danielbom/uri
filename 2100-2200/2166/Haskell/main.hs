import Text.Printf (printf)

parse :: String -> Int
parse = read

approxSqrt2 :: Int -> Double
approxSqrt2 n | n <= 0 = 1.0
approxSqrt2 n0 = 1.0 + go 0.0 n0
    where go x n
            | n <= 1    = x'
            | otherwise = go x' (n-1)
            where x' = 1.0 / (2.0 + x)

display :: Double -> String
display = printf "%.10f"

main :: IO ()
main = getLine >>=
    putStrLn
    . display
    . approxSqrt2
    . parse
