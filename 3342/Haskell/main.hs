
countHouses x = if even x then (e, e) else (e + 1, e)
    where xx = x * x
          e = xx `div` 2

makeMessage (white, black) =
    show white ++ " casas brancas e " ++ show black ++ " casas pretas"

main = interact $ unlines . map (makeMessage . countHouses . read) . lines

