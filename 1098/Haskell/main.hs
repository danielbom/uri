-- https://www.urionlinejudge.com.br/judge/en/problems/view/1096

import Text.Printf

sequenceIJ = do
  i <- [0..10]
  j <- [1,2,3]
  let k = fromIntegral i * 0.2 :: Double
  if i `mod` 5 == 0
    then return $ printf "I=%.0f J=%.0f" k (j + k)
    else return $ printf "I=%.1f J=%.1f" k (j + k)

main = putStr $ unlines sequenceIJ
