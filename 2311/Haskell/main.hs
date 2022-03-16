-- https://www.beecrowd.com.br/judge/en/problems/view/2311
import Text.Printf

data DiveScore = DiveScore
  { diverName  :: String
  , diveDifficulty :: Float
  , diverScores :: [Float]
  }

createDiveScores :: [String] -> [DiveScore]
createDiveScores (name:difficulty:scores:xs) =
  dive:createDiveScores xs
  where dive = DiveScore name (read difficulty) (map read $ words scores)
createDiveScores _ = []

diveScoreResult :: DiveScore -> Float
diveScoreResult dive = 
  diveDifficulty dive * (total - min - max)
  where scores = diverScores dive
        total = sum scores
        min = minimum scores
        max = maximum scores

showDiveResult :: DiveScore -> String
showDiveResult dive = 
  diverName dive ++ printf " %.2f" (diveScoreResult dive)

main :: IO ()
main = interact
  $ unlines
  . map showDiveResult
  . createDiveScores
  . tail
  . lines
