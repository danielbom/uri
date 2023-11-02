-- https://www.beecrowd.com.br/judge/en/problems/view/1983

import Data.List as L

type Student = (Double, Int)

unreachedText = "Minimum note not reached\n"

readStudent :: String -> Student
readStudent line = (read studentScore, read studentId)
  where [studentId, studentScore] = words line

showBestStudent :: Student -> String
showBestStudent (studentScore, studentId) = 
  if studentScore >= 8.0
    then show studentId ++ "\n"
    else unreachedText

main :: IO ()
main = interact $ showBestStudent . L.foldl' max (0.0, 0) . map readStudent . tail . lines
