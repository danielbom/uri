-- https://www.beecrowd.com.br/judge/en/problems/view/1180
import Data.Maybe

zipPair :: Int -> String -> (Int, Int)
zipPair i x = (read x, i)

pairToMsg :: (Int, Int) -> String
pairToMsg (x, i) = 
  unlines ["Menor valor: " ++ show x, "Posicao: " ++ show i]

main :: IO ()
main = interact
  $ pairToMsg
  . minimum
  . zipWith zipPair [0..]
  . concat
  . map words
  . tail
  . lines
