import Text.Printf (printf)
import Data.List (foldl')

parse :: String -> Int
parse = read

sqrt10 :: Int -> Double
sqrt10 n = 3.0 + foldl' (\acc _ -> 1.0 / (6.0 + acc)) 0.0 [1..n]

display :: Double -> String
display = printf "%.10f"

main :: IO ()
main = getLine >>=
    putStrLn
    . display
    . sqrt10
    . parse
