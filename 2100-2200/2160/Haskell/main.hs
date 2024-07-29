
main :: IO ()
main = getLine >>= 
    putStrLn
    . (\yes -> if yes then "YES" else "NO")
    . (<=80)
    . length
