-- https://www.beecrowd.com.br/judge/en/problems/view/1960

import Data.List as L

readInt :: String -> Int
readInt = read

threasholdDiff limit a b = abs (a - b) <= limit

main :: IO ()
main = do
  line1 <- getLine
  line2 <- getLine
  let jumpHeight = readInt . head . words $ line1
      pipes = map readInt . words $ line2
      win = L.and $ zipWith (threasholdDiff jumpHeight) pipes (tail pipes)
  if win
  then putStrLn "YOU WIN"
  else putStrLn "GAME OVER"
