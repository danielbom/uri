-- https://www.beecrowd.com.br/judge/en/problems/view/1186

import Text.Printf
import Control.Monad

secondaryDiagonal :: [Double] -> [Double]
secondaryDiagonal xs = go xs 12
    where go [] _ = []
          go _ 0  = []
          go ys n = start ++ go end (n-1) 
            where ys' = drop n ys
                  (start, end) = splitAt (12-n) ys'

average :: [Double] -> Double
average xs = sum xs / fromIntegral (length xs)

useOp :: String -> ([Double] -> Double)
useOp "M" = average
useOp "S" = sum
useOp op  = error $ "Unknown operator: " ++ op

main = do
    op <- getLine
    xs <- replicateM 144 readLn 
    putStr . printf "%.1f\n" . useOp op . secondaryDiagonal $ xs
