-- https://www.beecrowd.com.br/judge/en/problems/view/1933

readInts :: String -> [Int]
readInts = map read . words

main :: IO ()
main = do
    cards <- fmap readInts getLine
    putStrLn $ show $ foldr max 0 cards
