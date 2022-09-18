-- https://www.beecrowd.com.br/judge/en/problems/view/1181
import Text.Printf

takeNthLine :: Int -> Int -> [a] -> [a]
takeNthLine line columns xs = go 0 0 xs
  where
    go lin col [] = []
    go lin col ys@(x:xs)
      | col == columns = go (lin+1) 0 ys
      | lin == line    = x:go lin (col+1) xs
      | lin >  line    = []
      | otherwise      = go lin (col+1) xs

numberOfColumns = 12

computeOperationOnColumn :: Int -> ([Float] -> Float) -> IO ()
computeOperationOnColumn line operation = interact
  $ printf "%.1f\n"
  . operation
  . map (read :: String -> Float)
  . takeNthLine line numberOfColumns
  . lines

average :: Fractional a => [a] -> a
average xs = sum xs / (fromIntegral $ length xs)

main :: IO ()
main = do
  line <- fmap read getLine
  operation <- getLine
  case operation of
    "S" -> computeOperationOnColumn line sum
    "M" -> computeOperationOnColumn line average
    _ -> error $ "Invalid operation: " ++ operation
