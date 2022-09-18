-- https://www.beecrowd.com.br/judge/en/problems/view/2747

main :: IO ()
main = do
    let line = take 39 $ repeat '-'
        block = "|" ++ take 37 (repeat ' ') ++ "|"

    putStrLn line
    putStrLn block
    putStrLn block
    putStrLn block
    putStrLn block
    putStrLn block
    putStrLn line
