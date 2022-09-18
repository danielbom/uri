-- https://www.beecrowd.com.br/judge/en/problems/view/1557

padStart :: Int -> Char -> String -> String
padStart n ch s = replicate (n - length s) ch ++ s

createMatrix :: Int -> [[Int]]
createMatrix n = map (\i -> map (\j -> valueOf i j) [1..n]) [1..n]
  where valueOf i j = 2 ^ (i + j - 2)

matrixToString :: [[Int]] -> String
matrixToString mat = unlines $ map (unwords . map fmt) mat
  where k = length . show . last . last $ mat
        fmt = padStart k ' ' . show

main :: IO ()
main = interact $
  unlines .
  map (matrixToString . createMatrix) .
  takeWhile (/= 0) .
  map read .
  lines
