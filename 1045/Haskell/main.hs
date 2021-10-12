import Data.List

equalsWithError :: (Ord a, Num a) => a -> a -> a -> Bool
equalsWithError precision x y = (x - precision) < y && (x + precision) > y

checkTriangle :: (Ord a, Fractional a) => [a] -> String
checkTriangle (x:y:z:xs) 
  | z >= x + y    = "NAO FORMA TRIANGULO\n"
  | zz > xx + yy  = "TRIANGULO OBTUSANGULO\n" ++ eq
  | zz < xx + yy  = "TRIANGULO ACUTANGULO\n" ++ eq
  | otherwise     = "TRIANGULO RETANGULO\n"
  where xx = x * x
        yy = y * y
        zz = z * z
        isEq x y = fromEnum $ equalsWithError 1e-6 x y
        eq = case isEq x y + isEq y z + isEq x z of
          1 -> "TRIANGULO ISOSCELES\n"
          3 -> "TRIANGULO EQUILATERO\n"
          _ -> ""
checkTriangle _ = []

read' :: String -> Double
read' = read

main = interact (checkTriangle . sort . map (toRational . read') . words)
