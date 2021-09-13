-- https://www.urionlinejudge.com.br/judge/en/problems/view/1238

intercalate [] ys = ys
intercalate xs [] = xs
intercalate (x:xs) ys = x : intercalate ys xs

intercalate' [xs, ys] = intercalate xs ys
intercalate' _ = []

main = interact (unlines . map (intercalate' . words) . tail . lines)
