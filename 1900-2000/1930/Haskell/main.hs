-- https://www.beecrowd.com.br/judge/en/problems/view/1914

readInts :: String -> [Int]
readInts = map read . words

main :: IO ()
main = do
    strips <- fmap readInts getLine
    let outlets = sum strips - (length strips - 1)
    putStrLn $ show outlets
