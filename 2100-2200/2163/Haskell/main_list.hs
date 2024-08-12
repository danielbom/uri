type Point = (Int, Int)

notFound :: Point
notFound = (-2, -2)

lightSaberWave :: [[Int]]
lightSaberWave = [[7, 7, 7],[7, 42, 7], [7, 7, 7]]

parse :: IO [[Int]]
parse = do
    [n, _] <- fmap (map read . words) getLine
    let parseRow _ = fmap (map read . words) getLine
    mapM parseRow [1..n]

startWith :: Eq a => [a] -> [a] -> Bool
startWith [] _ = True
startWith _ [] = False
startWith (x:xs) (y:ys) = x == y && startWith xs ys

match :: Eq a => [[a]] -> [[a]] -> Bool
match [] _ = True
match _ [] = False
match (xs:pat) (ys:mat) = startWith xs ys && match pat mat

findPattern :: [[Int]] -> [[Int]] -> Point
findPattern pat0 mat0 = go 0 0 mat0
    where goNext i j = 
            let nextMat = map (drop j) mat0
            in case nextMat of
              ((_:_):_) -> go 0 j nextMat
              _         -> notFound

          go i j []  = goNext i (j + 1)
          go i j mat = 
            if match pat0 mat
                then (i, j)
                else go (i + 1) j (tail mat)

process :: [[Int]] -> Point
process = findPattern lightSaberWave

display :: Point -> String
display (x, y) = show (x + 2) ++ " " ++ show (y + 2)

main :: IO ()
main = do
    matrix <- parse
    putStrLn . display . process $ matrix
