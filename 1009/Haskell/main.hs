-- https://www.urionlinejudge.com.br/judge/en/problems/view/1009
import Text.Printf

round2 :: Double  -> Double 
round2 = (/ 100) . fromIntegral . round . (* 100)

main = do
    seller <- getLine
    fixSalary <- getLine
    totalSales <- getLine

    let total = read fixSalary + (read totalSales * 0.15)
    printf "TOTAL = R$ %.2f\n" (round2 total)
