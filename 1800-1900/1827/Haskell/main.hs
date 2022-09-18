-- https://www.beecrowd.com.br/judge/en/problems/view/1827

createMatrix :: Int -> [[Int]]
createMatrix n = map (\i -> map (\j -> valueOf i j) [1..n]) [1..n]
    where start = n `div` 3
          end = n - start
          middle = (n `div` 2) + 1
          exactMiddle i j = i == middle && j == middle
          inMiddle i j = start < i && i <= end && start < j && j <= end
          valueOf i j 
            | exactMiddle i j = 4
            | inMiddle i j    = 1
            | j == n - i + 1  = 3
            | i == j          = 2
            | otherwise       = 0

matrixToString :: [[Int]] -> String
matrixToString = unlines . map (concat . map show)

main = interact $ unlines . map (matrixToString . createMatrix . read) . lines
