import Data.List


main = interact 
    $ unlines
    . map ((\[x, y] -> show . sum $ filter odd [x+1..y-1]) . sort . map read . words)
    . tail
    . lines
