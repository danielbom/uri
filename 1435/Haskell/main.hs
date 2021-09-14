-- https://www.urionlinejudge.com.br/judge/en/problems/view/1435

squareMatrix n = reverse rest ++ midRows ++ rest
  where 
    m = (n - 1) `div` 2
    mid = [1..(m + 1)]
    midEven = mid ++ reverse mid 
    midOdd = mid ++ tail (reverse mid)
    midRow = if even n then midEven else midOdd
    midRows = if even n then [midRow, midRow] else [midRow]
    calcRest 0 _ = []
    calcRest i xs = map (min i) xs : calcRest (i - 1) xs
    rest = calcRest m midRow

padStart :: Char -> Int -> String -> String
padStart ch n xs = go (n - length xs)
  where 
    go i
      | i > 0 = ch:go (i - 1)
      | otherwise = xs

printi :: Integer -> String
printi = padStart ' ' 3 . show

createMatrix = unlines . map (unwords . map printi) . squareMatrix

main = interact (unlines . map createMatrix . takeWhile (> 0) . map read . lines)
