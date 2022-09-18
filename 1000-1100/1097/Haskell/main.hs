-- https://www.urionlinejudge.com.br/judge/en/problems/view/1096

sequenceIJ = do
  i <- [1,3,5,7,9]
  j <- [7,6,5]
  return $ "I=" ++ show i ++ " J=" ++ show (j + i - 1)

main = putStr $ unlines sequenceIJ
