compute :: String -> [Int]
compute line =
    let [n, xp] = map read $ words line
    in if n == 0
        then []
        else [n * xp] 

main :: IO ()
main = interact
    $ unlines
    . map show
    . concat
    . takeWhile (not . null)
    . map compute
    . lines
