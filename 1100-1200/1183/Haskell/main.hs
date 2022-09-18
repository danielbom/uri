-- https://www.beecrowd.com.br/judge/en/problems/view/1183
import Text.Printf

aboveDiagonal :: Int -> [a] -> [a]
aboveDiagonal columns xs = go 0 0 xs
  where
    go lin col [] = []
    go lin col ys@(x:xs)
      | col == columns = go (lin+1) 0 ys
      | col > lin      = x: go lin (col+1) xs
      | lin > columns  = []
      | otherwise      = go lin (col+1) xs

numberOfColumns = 12

computeOperationOnColumn :: ([Float] -> Float) -> IO ()
computeOperationOnColumn operation = interact
  $ printf "%.1f\n"
  . operation
  . map (read :: String -> Float)
  . aboveDiagonal numberOfColumns
  . lines

average :: Fractional a => [a] -> a
average xs = sum xs / (fromIntegral $ length xs)

main :: IO ()
main = do
  operation <- getLine
  case operation of
    "S" -> computeOperationOnColumn sum
    "M" -> computeOperationOnColumn average
    _ -> error $ "Invalid operation: " ++ operation
