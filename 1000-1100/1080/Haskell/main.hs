
showResult :: (Integer, Integer) -> String
showResult (x, i) = unlines [show x, show i]

main = interact (showResult . maximum . zipWith (flip (,)) [1..] . map read . lines)
