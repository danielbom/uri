import Text.Printf

weightedAverages :: String -> String
weightedAverages line = printf "%.1f" (v / w)
    where xs = map read . words $ line
          ws = [2.0, 3.0, 5.0] :: [Float]
          v = sum (zipWith (*) xs ws)
          w = sum ws

main = interact (unlines . map weightedAverages . tail . lines)
