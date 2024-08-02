import Text.Printf (printf)

parse :: String -> Int
parse = read

fastFibonacci :: Int -> Double
fastFibonacci n = (((1 + fiveSqrt) / 2) ^ n - ((1 - fiveSqrt) / 2) ^ n) / fiveSqrt
    where fiveSqrt = sqrt 5.0

display :: Double -> String
display = printf "%.1f"

main :: IO ()
main = getLine >>=
    putStrLn
    . display
    . fastFibonacci
    . parse
