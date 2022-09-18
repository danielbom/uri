-- https://www.urionlinejudge.com.br/judge/en/problems/view/2378

import Control.Applicative
import Data.Traversable

toTuple [x, y] = (x, y)
toTuple _      = (0, 0)

readNums :: IO (Integer, Integer)
readNums = toTuple . map read . words <$> getLine

increment x (o, i) = x - o + i

main = do
  (n, capacity) <- readNums
  xs <- for [1..n] (const readNums)
  if all (<= capacity) $ scanl increment 0 xs
    then putStrLn "N"
    else putStrLn "S"
