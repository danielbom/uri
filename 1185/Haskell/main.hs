-- https://www.beecrowd.com.br/judge/en/problems/view/1184
import Text.Printf

topSecondaryDiagonal :: Int -> [a] -> [a]
topSecondaryDiagonal columns xs = go 0 0 xs
  where
    go lin col [] = []
    go lin col ys@(x:xs)
      | lin > sndColumn = []
      | col == columns  = go (lin+1) 0 ys
      | col < sndColumn = x: go lin (col+1) xs
      | otherwise       = go lin (col+1) xs
      where sndColumn = columns - lin

numberOfColumns = 12

computeOperationOnColumn :: ([Float] -> Float) -> IO ()
computeOperationOnColumn operation = interact
  $ printf "%.1f\n"
  . operation
  . map (read :: String -> Float)
  . topSecondaryDiagonal numberOfColumns
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
