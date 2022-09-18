-- https://www.urionlinejudge.com.br/judge/en/problems/view/1828

groupCaws :: [String] -> [[String]]
groupCaws = foldr group [[]]
  where 
    group ::  String -> [[String]] -> [[String]]
    group "caw caw" xxs = []:xxs
    group x (xs:xxs) = (x:xs):xxs
    group _ [] = []

lotteryValue :: String -> Integer
lotteryValue blink = case blink of 
  "--*" -> 1
  "-*-" -> 2
  "-**" -> 3
  "*--" -> 4
  "*-*" -> 5
  "**-" -> 6
  "***" -> 7
  _ -> 0

lotteryResult :: [String] -> String
lotteryResult = show . sum . map lotteryValue

main = interact (unlines . map lotteryResult . groupCaws . init . lines)
