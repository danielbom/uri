-- https://www.urionlinejudge.com.br/judge/en/problems/view/1000

deleteAt i xs = [x | (k, x) <- zip [0..] xs, k /= i]

squareMatrix x = 
  if even x
    then row1 ++ row2
    else deleteAt n $ map (deleteAt n) result
  where n = x `div` 2
        q1' = map (\x -> replicate (n - x) 1 ++ [1..x]) [1..n]
        q1 = if even x then q1' else map (init . (++ [1])) q1'
        q2 = map reverse q1
        row1 = zipWith (++) q1 q2
        row2 = reverse row1
        result = squareMatrix (x + 1)

joinWith _ [] = []
joinWith ys (x:xs) = x ++ ys ++ joinWith ys xs

main = interact $
    unlines 
    . map (unlines . map (("  " ++) . joinWith "   " . map show). squareMatrix) 
    . takeWhile (> 0)
    . map read
    . lines
