import Text.Printf

main = printf "%.2f\n" (s :: Double)
    where s = sum $ map recip [1..100]
