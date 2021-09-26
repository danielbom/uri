import Text.Printf

arrayFill :: Integer -> String
arrayFill n = unlines $ map fill [0..999]
    where fill i = printf "N[%d] = %d" i (i `mod` n)

main = do
    n <- readLn
    putStr $ arrayFill n

