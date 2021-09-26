
solve (x:xs) = 
    case zs of
        (z:_) -> (++"\n") . show $ go z x 0 0
        _     -> [] 
    where zs = dropWhile (<=x) xs
          go z i s c = if s > z then c else go z (i+1) (s+i) (c+1)
solve _ = []

main = interact (solve . map read . lines)

