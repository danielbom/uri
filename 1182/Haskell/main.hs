-- https://www.beecrowd.com.br/judge/en/problems/view/1182
import Text.Printf

takeNthColumns :: Int -> Int -> [a] -> [a]
takeNthColumns n columns xs = go 0 xs
  where
    go col [] = []
    go col ys@(x:xs)
      | col == columns = go 0 ys
      | col == n       = x: go (col+1) xs
      | otherwise      = go (col+1) xs

numberOfColumns = 12

computeOperationOnColumn :: Int -> ([Float] -> Float) -> IO ()
computeOperationOnColumn column operation = interact
  $ printf "%.1f\n"
  . operation
  . map (read :: String -> Float)
  . takeNthColumns column numberOfColumns
  . lines

average :: Fractional a => [a] -> a
average xs = sum xs / (fromIntegral $ length xs)

main :: IO ()
main = do
  column <- fmap read getLine
  operation <- getLine
  case operation of
    "S" -> computeOperationOnColumn column sum
    "M" -> computeOperationOnColumn column average
    _ -> error $ "Invalid operation: " ++ operation
