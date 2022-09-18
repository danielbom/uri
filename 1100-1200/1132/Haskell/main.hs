
main = do
    x <- fmap read getLine 
    y <- fmap read getLine 
    let xs = if x < y then [x..y] else [y..x]
    print . sum . filter (\x -> x `mod` 13 /= 0) $ xs

