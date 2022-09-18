-- https://www.beecrowd.com.br/judge/en/problems/view/1188
import Control.Monad
import Text.Printf

average xs = (sum xs) / (fromIntegral $ length xs)

topArea :: [Double] -> [Double]
topArea xs = concat $ go xs (Left 1)
    where
        go [] _ = []
        go ys (Left i) = go (drop i ys) (Right (i + 1))
        go ys (Right i) = start' : go end' (Left (i + 1))
            where (start', end') = splitAt (12 - i) ys

inferiorArea :: [Double] -> [Double]
inferiorArea = topArea . reverse

main = do
    op <- getLine
    xs <- replicateM 144 readLn 
    let ys = inferiorArea xs

    if op == "M" then
        putStr $ printf "%.1f\n" (average ys :: Double)
    else
        putStr $ printf "%.1f\n" (sum ys :: Double)
