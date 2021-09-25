import Text.Printf


main = printf "%.2f\n" (s :: Double)
    where xs = 1:map (*2) xs
          s = sum $ zipWith (/) [1,3..39] xs

