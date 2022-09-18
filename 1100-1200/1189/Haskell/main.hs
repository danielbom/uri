-- https://www.beecrowd.com.br/judge/en/problems/view/1188
import Control.Monad
import Text.Printf

average xs = (sum xs) / (fromIntegral $ length xs)

leftArea :: [Double] -> [Double]
leftArea xs = concat $ go xs (Left 0)
    where
        splitWith i ys f = start' : go rest (f i)
            where start' = take i ys
                  rest = drop 12 ys
        go [] _ = []
        go ys (Left 6) = go ys (Right 5)
        go ys (Left i) = splitWith i ys (Left . succ) 
        go ys (Right i) = splitWith i ys (Right . pred)

useOp :: String -> ([Double] -> Double)
useOp "M" = average
useOp "S" = sum
useOp op  = error $ "Invalid operator: " ++ op

main = do
    op <- getLine
    xs <- replicateM 144 readLn 
    putStr . printf "%.1f\n" . useOp op . leftArea $ xs
