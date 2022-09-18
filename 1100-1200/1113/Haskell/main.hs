import Data.Maybe

rangeAnalyse :: [Integer] -> String
rangeAnalyse (x:y:_)
    | x < y     = "Crescente"
    | x > y     = "Decrescente"
    | otherwise = ""
rangeAnalyse _  = ""

main = interact (unlines . takeWhile (not . null) . map (rangeAnalyse . map read . words) . lines)
