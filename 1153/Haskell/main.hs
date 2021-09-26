factorial n = product [1..n]

main = interact (unlines . map (show . factorial . read) . lines)
