
main = interact ((++ " valores pares\n") . show . length . filter ((==0) . (`mod` 2) . abs) . map read . lines)

