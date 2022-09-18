-- https://www.urionlinejudge.com.br/judge/en/problems/view/1000

import Text.Printf 

safeDiv [a, b] = 
  let x = read a :: Integer
      y = read b :: Integer
  in if y /= 0 then Just (fromIntegral x / fromIntegral y) else Nothing
safeDiv _ = Nothing

showResult :: Maybe Double -> String
showResult Nothing = "divisao impossivel"
showResult (Just x) = printf "%.1f" x

main = interact (unlines . map (showResult . safeDiv . words) . tail . lines)
