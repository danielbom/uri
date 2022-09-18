-- https://www.urionlinejudge.com.br/judge/en/problems/view/1858

data People = People 
  { getIndex :: Integer
  , getValue :: Integer
  }

instance Eq People where
  (People _ v1) == (People _ v2) = v1 == v2

instance Ord People where
  (People _ v1) `compare` (People _ v2) = v1 `compare` v2

main = do
  _ <- getLine
  line <- getLine
  print . getIndex . minimum . zipWith People [1..] . map read . words $ line
