-- https://www.urionlinejudge.com.br/judge/en/problems/view/1000

import Text.Printf

data Avg = Avg Integer Integer

getAvg (Avg sum count) = fromIntegral sum / fromIntegral count

concatAvg (Avg s1 c1) (Avg s2 c2) = Avg (s1 + s2) (c1 + c2)

emptyAvg = Avg 0 0

pureAvg x = Avg x 1

present :: Double -> String
present = printf "%.2f\n"

main = interact (present . getAvg . foldr (concatAvg . pureAvg) emptyAvg . takeWhile (> 0) . map read . lines)
