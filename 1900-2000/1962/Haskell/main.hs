-- https://www.beecrowd.com.br/judge/en/problems/view/1960

timePassed :: Int -> String
timePassed years = 
  if passed >= 0
    then show (passed + 1) ++ " D.C."
    else show (-passed) ++ " A.C."
  where passed = (2015 - years - 1)

main :: IO ()
main = interact $ unlines . map (timePassed . read) . tail . lines 
