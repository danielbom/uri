-- https://www.beecrowd.com.br/judge/en/problems/view/1173

showIdx :: Int -> Int -> String
showIdx i x = "N[" ++ show i ++ "] = " ++ show x

main :: IO ()
main = do
  x <- getLine
  putStr 
    . unlines
    . zipWith showIdx [0..9]
    $ iterate (*2) (read x)
