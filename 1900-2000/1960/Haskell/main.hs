
romanSequence = 
  [(1000, "M")
  ,(900, "CM")
  ,(500, "D")
  ,(400, "CD")
  ,(100, "C")
  ,(90, "XC")
  ,(50, "L")
  ,(40, "XL")
  ,(10, "X")
  ,(9, "IX")
  ,(5, "V")
  ,(4, "IV")
  ,(1, "I")
  ]

romanToArabic :: Int -> String
romanToArabic x = snd $ foldl go (x, "") romanSequence
  where go acc@(x', result) (y, roman) =
          if x' >= y
          then (x' - y', result ++ replicate k roman)
          else acc
          where k = x' `div` y
                y' = y * k

romanNumeral :: Int -> String
romanNumeral x
  | x >= 1000 = "M"  ++ romanNumeral (x - 1000)
  | x >= 900  = "CM" ++ romanNumeral (x - 900)
  | x >= 500  = "D"  ++ romanNumeral (x - 500)
  | x >= 400  = "CD" ++ romanNumeral (x - 400)
  | x >= 100  = "C"  ++ romanNumeral (x - 100)
  | x >= 90   = "XC" ++ romanNumeral (x - 90)
  | x >= 50   = "L"  ++ romanNumeral (x - 50)
  | x >= 40   = "XL" ++ romanNumeral (x - 40)
  | x >= 10   = "X"  ++ romanNumeral (x - 10)
  | x >= 9    = "IX" ++ romanNumeral (x - 9)
  | x >= 5    = "V"  ++ romanNumeral (x - 5)
  | x >= 4    = "IV" ++ romanNumeral (x - 4)
  | x >= 1    = "I"  ++ romanNumeral (x - 1)
  | otherwise = ""

main :: IO ()
main = readLn >>= putStrLn . romanToArabic