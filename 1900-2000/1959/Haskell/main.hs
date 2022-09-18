-- https://www.beecrowd.com.br/judge/en/problems/view/1959

readInts :: String -> [Integer]
readInts = map read . words

main :: IO ()
main = do
    line <- getLine
    case readInts line of
        [sides, len] -> print (sides * len)
        _            -> error ("Invalid input: " ++ line)
