parseRow :: IO [Int]
parseRow = fmap (map read . words) getLine

parse :: IO [[Int]]
parse = do
    n <- fmap read getLine
    mapM (const parseRow) [1..(n + 1)]

-- https://github.com/sanctuary-js/sanctuary-type-classes
conv2dFold :: (b -> a) -> (a -> a -> a) -> [[b]] -> [[a]]
conv2dFold of' concat' (row1:row2:rest) = conv:conv2dFold of' concat' (row2:rest)
    where row' = zipWith concat' (map of' row1) (map of' row2)
          conv = zipWith concat' row' (tail row')
conv2dFold _ _ _ = []

process :: [[Int]] -> [[Bool]]
process = map (map (>=2)) . conv2dFold (id) (+)

displayRow :: [Bool] -> String
displayRow = concatMap (\safe -> if safe then "S" else "U")

display :: [[Bool]] -> String
display = unlines . map displayRow

main :: IO ()
main = do
    surveillanceCameras <- parse
    putStr . display . process $ surveillanceCameras
