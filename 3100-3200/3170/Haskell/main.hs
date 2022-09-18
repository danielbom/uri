-- https://www.urionlinejudge.com.br/judge/en/problems/view/1000

main = do
  balls <- getLine
  branchs <- getLine

  let expectedBalls = read branchs / 2
      currentBalls = read balls

  if expectedBalls <= currentBalls 
    then putStrLn "Amelia tem todas bolinhas!"
    else 
      let missingBalls = floor (expectedBalls - currentBalls)
      in putStrLn $ "Faltam " ++ show missingBalls ++ " bolinha(s)"
