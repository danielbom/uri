-- https://www.beecrowd.com.br/judge/en/problems/view/1963

import Text.Printf as P

readDouble :: String -> Double
readDouble = read

percentageBetween :: (Floating a) => a -> a -> a
percentageBetween x y = (y / x) - 1

main :: IO ()
main = do
  [lastPrice, newPrice] <- fmap (map readDouble . words) getLine
  putStrLn $ P.printf "%.2f%%" $ 100 * percentageBetween lastPrice newPrice
