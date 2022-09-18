-- https://www.urionlinejudge.com.br/judge/en/problems/view/1435

padStart :: Int -> Char -> String -> String
padStart n c s = replicate (n - length s) c ++ s

createMatrix :: Int -> [[Int]]
createMatrix n = map (\i -> map (\j -> valueOf i j) [1..n]) [1..n]
  where valueOf i j = succ . abs $ i - j

matrixToString :: [[Int]] -> String
matrixToString = unlines . map (unwords . map (padStart 3 ' ' . show)) 

main :: IO ()
main = interact 
  $ unlines 
  . map (matrixToString . createMatrix)
  . takeWhile (/=0) 
  . map read 
  . lines