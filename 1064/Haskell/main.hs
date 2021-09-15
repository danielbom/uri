-- https://www.urionlinejudge.com.br/judge/en/problems/view/1009

import Text.Printf

out :: [Float] -> String
out xs = printf "%d valores positivos\n%.1f\n" n avg
  where n = length xs
        avg = sum xs / fromIntegral n

main = interact (out . filter (> 0.0) . map read . lines)
