-- https://www.beecrowd.com.br/judge/en/problems/view/1174
import Data.Maybe

main :: IO ()
main = interact
  $ unlines
  . catMaybes
  . zipWith (\i x ->
    if x <= 10.0
    then Just $ "A[" ++ show i ++ "] = " ++ show x
    else Nothing)
    [0..100]
  . map read
  . lines
