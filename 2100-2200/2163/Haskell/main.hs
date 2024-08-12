import Data.Array (Array, listArray, bounds, (!))
import Debug.Trace (trace)

type Matrix = Array Int (Array Int Int)

type Point = (Int, Int)

notFound :: Point
notFound = (-2, -2)

matrixArray :: Int -> Int -> [[Int]] -> Matrix
matrixArray rows cols values = listArray (1, rows) $ map (listArray (1, cols)) values

lightSaberWave :: Matrix
lightSaberWave = matrixArray 3 3 [[7, 7, 7],[7, 42, 7], [7, 7, 7]]

parse :: IO Matrix
parse = do
    [rows, cols] <- fmap (map read . words) getLine
    let parseRow _ = fmap (map read . words) getLine
    matrix <- mapM parseRow [1..rows]
    return $ matrixArray rows cols matrix

findPattern :: Matrix -> Matrix -> Point
findPattern pat mat = go 0 0 
  where (_, matRows) = bounds mat
        (_, matCols) = if matRows > 0 then bounds (mat ! 1) else (0, 0)
        
        (_, patRows) = bounds pat
        (_, patCols) = if patRows > 0 then bounds (pat ! 1) else (0, 0)

        check i j =
          all id [px == mx 
                  | pi <- [1..patRows]
                  , pj <- [1..patCols]
                  , let mx = mat ! (i + pi) ! (j + pj)
                  , let px = pat ! pi ! pj]

        go i j
          | i + patRows > matRows = notFound
          | j + patCols > matCols = go (i + 1) 0
          | check i j              = (i, j)
          | otherwise              = go i (j + 1)

process :: Matrix -> Point
process = findPattern lightSaberWave

display :: Point -> String
display (x, y) = show (x + 2) ++ " " ++ show (y + 2)

main :: IO ()
main = do
    matrix <- parse
    putStrLn . display . process $ matrix
