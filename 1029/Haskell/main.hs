-- https://www.urionlinejudge.com.br/judge/en/problems/view/1029

data Fib = Fib 
  { fibValue :: Integer
  , fibCalls :: Integer
  , fibOnes :: Integer
  }

fibNext (Fib a1 c1 o1) (Fib a2 c2 o2) = Fib (a1 + a2) (c1 + c2 + 1) (o1 + o2)

fibCount = Fib 0 1 0 : Fib 1 1 1 : zipWith fibNext fibCount (tail fibCount)

showFib n = do
  let fn = fibCount !! read n
  "fib(" ++ n ++ ") = " ++ show (fibCalls fn - 1) ++ " calls = " ++ show (fibOnes fn)

main = interact (unlines . map showFib . tail . lines)
