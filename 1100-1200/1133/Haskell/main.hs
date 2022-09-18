import Control.Applicative

restOfDivision :: Int -> Int -> String
restOfDivision x y = 
    unlines
    . map show
    . filter ((`elem` [2,3]) . (`mod` 5))
    $ [start + 1..end - 1]
    where start = if x < y  then x else y
          end   = if x >= y then x else y

main = do
    result <- restOfDivision <$> readLn <*> readLn
    putStr result

