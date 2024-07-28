main :: IO ()
main = interact 
    $ unlines
    . map (show . (\x -> x - 1) . read)
    . lines
