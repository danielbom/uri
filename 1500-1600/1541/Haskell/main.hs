-- https://www.beecrowd.com.br/judge/en/problems/view/1541

parseInput :: String -> (Double, Double, Double)
parseInput input = 
  let values = map read $ words input
      [a, b, c] = values
  in (a, b, c) 

maximumBuildSize :: (Double, Double, Double) -> Int
maximumBuildSize (a, b, c) = floor side
  where area = a * b * (100.0 / c)
        side = sqrt area

main :: IO ()
main = interact $
  unlines
  . map (show . maximumBuildSize . parseInput)
  . takeWhile (/= "0")
  . lines
