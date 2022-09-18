

main = interact $ 
    unlines
    . map (\n -> unwords $ map show [1..n])
    . takeWhile (>0)
    . map read
    . lines
