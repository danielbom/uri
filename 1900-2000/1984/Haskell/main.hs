-- https://www.beecrowd.com.br/judge/en/problems/view/1983

readInt :: String -> Integer
readInt = read

main :: IO ()
main = do
  number <- fmap readInt getLine
  putStrLn . reverse . show $ number
