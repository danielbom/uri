-- https://www.urionlinejudge.com.br/judge/en/problems/view/1009

main = interact ((++ " valores positivos\n") . show . length . filter (> 0.0) . map read . lines)
