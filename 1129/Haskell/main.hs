
answers = [[c] | c <- "ABCDE"]

indexToAnswer :: [(Int, Int)] -> String
indexToAnswer [(i, _)] = answers !! i
indexToAnswer _ = "*"

opticalReader :: [Int] -> String
opticalReader [x] = ""
opticalReader xs = indexToAnswer . filter ((<=127) . snd) . zip [0..] $ xs

main = interact
    $ unlines
    . filter (not . null)
    . map (opticalReader . map read . words)
    . lines
