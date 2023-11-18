-- https://www.urionlinejudge.com.br/judge/en/problems/view/2003

import Data.List (span)
import Text.Printf (printf)

type Hours = Int

parseHours :: String -> Hours
parseHours text = 
  let (hours, minutes0) = span (/=':') text
      minutes = tail minutes0
  in read hours * 60 + read minutes

addHours :: Hours -> Hours -> Hours
addHours = (+) 

subHours :: Hours -> Hours -> Hours
subHours = (-)

toDelay :: Hours -> Int
toDelay hours
  | hours > 0 = 0
  | otherwise = -hours

maximumDelay :: String -> String
maximumDelay =
  (printf "Atraso maximo: %d")
  . toDelay
  . (subHours (parseHours "8:00"))
  . (addHours (parseHours "1:00"))
  . parseHours

main = interact $ unlines . map maximumDelay . lines
