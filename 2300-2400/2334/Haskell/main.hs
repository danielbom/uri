-- https://www.beecrowd.com.br/judge/en/problems/view/2334

readInteger :: String -> Integer
readInteger = read

main :: IO ()
main = interact
    $ unlines
    . map (show . max 0 . subtract 1 . readInteger)
    . takeWhile (/= "-1")
    . lines
