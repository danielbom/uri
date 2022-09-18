-- https://www.beecrowd.com.br/judge/en/problems/view/2685

between :: Int -> Int -> Int -> Bool
between start end value =
  start <= value && value < end

showMessage :: Int -> String
showMessage degree 
  | between 0   90  d = "Bom Dia!!"
  | between 90  180 d = "Boa Tarde!!"
  | between 180 270 d = "Boa Noite!!"
  | otherwise         = "De Madrugada!!"
  where d = mod degree 360

main :: IO ()
main = interact
  $ unlines
  . map (showMessage . read)
  . lines
