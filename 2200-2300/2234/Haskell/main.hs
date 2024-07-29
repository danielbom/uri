import Text.Printf (printf)

main :: IO ()
main = getLine >>= 
    putStrLn
    . printf "%.2f" 
    . (\(a:b:_) -> (a / b) :: Double)
    . map read
    . words 
