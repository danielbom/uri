main :: IO ()
main = do
    line <- getLine
    let [a, b, c] = map read $ words line
        try1 = [a, b, c] :: [Int]
        try2 = [a - b, a - c, b - c]
        try3 = [a + b - c, a + c - b, b + c - a]
        tries = try1 ++ try2 ++ try3
    if any (==0) tries
    then putStrLn "S"
    else putStrLn "N"
