import Data.List

checkTriangle :: [Rational] -> String
checkTriangle (x:y:z:xs) 
  | z >= x + y    = "NAO FORMA TRIANGULO\n"
  | zz > xx + yy  = "TRIANGULO OBTUSANGULO\n" ++ eq
  | zz < xx + yy  = "TRIANGULO ACUTANGULO\n" ++ eq
  | otherwise     = "TRIANGULO RETANGULO\n"
  where xx = x * x
        yy = y * y
        zz = z * z
        eq = if x == y && y == z then "TRIANGULO EQUILATERO\n" else "TRIANGULO ISOSCELES\n"
checkTriangle _ = []

readi :: String -> Double
readi = read

main = interact (checkTriangle . sort . map (toRational . readi) . words)
