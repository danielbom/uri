dropEven (x:y:xs) = y:dropEven xs
dropEven _ = []
                  
countWaves :: [Integer] -> Integer
countWaves xs = sum $ zipWith3 countWave xs ys (tail ys)
    where ys              = tail xs ++ xs
          isSort3   x y z = (x <= y && y <= z) || (x >= y && y >= z)
          countWave x y z = if not (isSort3 x y z) then 1 else 0

main = interact 
    $ unlines
    . map (show . countWaves . map read . words)
    . dropEven 
    . lines
