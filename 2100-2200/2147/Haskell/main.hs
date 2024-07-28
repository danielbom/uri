import Text.Printf (printf)

format :: Int -> String
format n = show int ++ btw ++ show frac
    where (int, frac) = n `divMod` 100
          btw = if frac < 10 then ".0" else "."

main :: IO ()
main = interact
    $ unlines
    . map (format . length)
    . tail
    . lines
