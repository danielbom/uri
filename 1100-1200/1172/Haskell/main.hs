import Text.Printf

replaceValue x 
    | x > 0     = x
    | otherwise = 1

showPosition :: Integer -> Integer -> String
showPosition = printf "X[%d] = %d"

main = interact (unlines . zipWith showPosition [0..] . map (replaceValue . read) . lines)
