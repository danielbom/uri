import Control.Applicative
import Text.Printf

readDouble :: IO Double
readDouble = read <$> getLine

fillArray :: Int -> Double -> String
fillArray i x = printf "N[%d] = %.4F" i x

main :: IO ()
main = readDouble >>= 
    putStr 
    . unlines 
    . zipWith fillArray [0..99]
    . iterate (/2.0)

