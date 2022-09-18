-- https://www.urionlinejudge.com.br/judge/en/problems/view/1096

import Text.Printf

data SciStat = Stat Integer Integer Integer

statEmpty = Stat 0 0 0

statAppend (Stat c1 r1 s1) (Stat c2 r2 s2) = Stat (c1 + c2) (r1 + r2) (s1 + s2)

showf :: Double -> String
showf = printf "%.2f"

instance Show SciStat where
  show (Stat c r s) = unlines
    [ "Total: " ++ show total ++ " cobaias"
    , "Total de coelhos: " ++ show c
    , "Total de ratos: " ++ show r
    , "Total de sapos: " ++ show s
    , "Percentual de coelhos: " ++ showf (percent c) ++ " %"
    , "Percentual de ratos: " ++ showf (percent r) ++ " %"
    , "Percentual de sapos: " ++ showf (percent s) ++ " %"
    ]
    where total = c + r + s
          percent x = (fromIntegral x / fromIntegral total) * 100.0

stat [n, typ] = case typ of
  "C" -> Stat (read n) 0 0
  "R" -> Stat 0 (read n) 0
  "S" -> Stat 0 0 (read n)
  _ -> statEmpty
stat _ = statEmpty

main = interact (show . foldr (statAppend . stat . words) statEmpty . tail . lines)
