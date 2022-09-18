-- https://www.urionlinejudge.com.br/judge/en/problems/view/1051

import Text.Printf

getTaxes :: Double -> Maybe Double
getTaxes salary
  | salary <= 2000.0 = Nothing 
  | salary <= 3000.0 = Just (0.08 * (salary - 2000))
  | salary <= 4500.0 = Just (0.08 * 1000 + 0.18 * (salary - 3000))
  | otherwise        = Just (0.08 * 1000 + 0.18 * 1500 + 0.28 * (salary - 4500))

main = do
  salary <- readLn
  case getTaxes salary of 
    Just taxes -> putStrLn $ printf "R$ %.2f" taxes
    Nothing -> putStrLn "Isento"
