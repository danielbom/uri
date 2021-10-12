

older :: [Integer] -> Integer
older xs = maximum children
    where children = foldl1 (-) xs : tail xs

main = interact $ (++"\n") . show . older . map read . lines

