import Debug.Trace (trace)

parse :: String -> [Int]
parse = map read . words

check :: [Int] -> Bool
check [ ] = True
check [x] = True
check (x:y:xs) = x /= y && go (x < y) (y:xs)
    where
        go upper (x:y:xs) 
            | upper     = x > y && go False (y:xs) 
            | otherwise = x < y && go True  (y:xs)
        go _ _ = True

display :: Bool -> String
display True = "1"
display False = "0"

main :: IO ()
main = do
    _ <- getLine
    line <- getLine
    putStrLn . display . check . parse $ line
