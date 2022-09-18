
toMsg x 
    | x > 0     = evenOddText ++ " POSITIVE" 
    | x < 0     = evenOddText ++ " NEGATIVE"
    | otherwise = "NULL"
    where evenOddText = if even x then "EVEN" else "ODD"

main = interact (unlines . map toMsg.  map read . tail . lines)

