-- https://www.urionlinejudge.com.br/judge/en/problems/view/1000

machineResult :: String -> String
machineResult line =
  case words line of
    [[missingCh], realValue] ->
      let typedValue = [ch | ch <- realValue, ch /= missingCh]
       in if null typedValue
            then "0"
            else show (read typedValue :: Integer)
    _ -> error "invalid line"

main :: IO ()
main = do
  line <- getLine
  if line == "0 0"
    then return ()
    else do
      putStrLn $ machineResult line
      main
