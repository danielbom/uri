-- https://www.urionlinejudge.com.br/judge/en/problems/view/3091
import Text.Printf

salaryRate salary 
  | salary <= 400.0  = 15
  | salary <= 800.0  = 12
  | salary <= 1200.0 = 10
  | salary <= 2000.0 = 7
  | otherwise        = 4

salaryAdjust :: Float -> IO ()
salaryAdjust salary = do
  let rate = salaryRate salary
      profit = salary * (rate / 100.0)
      newSalary = salary + profit
  putStrLn $ printf "Novo salario: %.2f" newSalary
  putStrLn $ printf "Reajuste ganho: %.2f" profit
  putStrLn $ printf "Em percentual: %.0f %%" rate

main = readLn >>= salaryAdjust
