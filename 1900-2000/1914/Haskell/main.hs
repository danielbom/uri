-- https://www.beecrowd.com.br/judge/en/problems/view/1914

readInts :: String -> [Integer]
readInts = map read . words

doNTimes :: Int -> IO () -> IO ()
doNTimes n io
    | n <= 0    = return ()
    | otherwise = do
        io 
        doNTimes (n - 1) io

evenOrOddPlay :: IO ()
evenOrOddPlay = do
    [player1, play1, player2, play2] <- fmap words getLine
    [number1, number2] <- fmap readInts getLine
    let winnerPlay = if even (number1 + number2) then "PAR" else "IMPAR"
        winner = if play1 == winnerPlay then player1
                 else if play2 == winnerPlay then player2
                 else error $ "Invalid play " ++ show (play1, play2) 
    putStrLn winner

main :: IO ()
main = do
    times <- fmap read getLine
    doNTimes times evenOrOddPlay
