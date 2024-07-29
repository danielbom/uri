import Text.Printf (printf)

ln :: Double -> Double
ln = log

approximatePrimes :: Double -> (Double, Double)
approximatePrimes n = (low, up)
    where low = n / log n
          up = 1.25506 * low

showResult :: (Double, Double) -> String
showResult (low, up) = printf "%.1f %.1f" low up

main :: IO ()
main = getLine >>=
    putStrLn
    . showResult
    . approximatePrimes
    . read
