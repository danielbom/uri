-- https://www.beecrowd.com.br/judge/en/problems/view/1958

import Data.List as L
import Text.Printf as P

ensureNumber :: String -> String
ensureNumber = constraints . preprocess
    where preprocess = L.dropWhile (=='+')
          constraints maybeNumber
            | L.isPrefixOf "." maybeNumber = constraints ('0':maybeNumber)
            | L.isSuffixOf "." maybeNumber = constraints (maybeNumber ++ "0")
            | null maybeNumber             = "0"
            | otherwise                    = maybeNumber

readDouble :: String -> Double
readDouble = read . ensureNumber

formatScientific :: Double -> String
formatScientific number = P.printf "%sE%s" realPart expPart''
    where numberS = P.printf "%+.4E" number
          (realPart, expPart) = L.span (/='E') numberS
          expPart' = read $ tail expPart :: Int
          expPart'' = P.printf "%+03d" expPart' :: String

main :: IO ()
main = interact $ unlines . map (formatScientific . readDouble) . lines
