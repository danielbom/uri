
main = do
  line <- getLine
  let [num, den] = map read $ words line
      (result, rest) = num `divMod` den
      (result', rest') = if num > 0 && den < 0 && rest /= 0
        then (result + 1, rest - den)
        else if num < 0 && den < 0 && rest /= 0
          then (result + 1, abs den + rest)
          else (result, rest)
  putStrLn $ show result' ++ " " ++ show rest'
