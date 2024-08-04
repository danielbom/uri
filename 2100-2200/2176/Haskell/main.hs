parity :: String -> String
parity bits
    | even ones = bits ++ "0"
    | otherwise = bits ++ "1"
    where ones = length $ filter (=='1') bits


main :: IO ()
main = getLine >>= putStrLn . parity
