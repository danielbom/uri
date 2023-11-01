-- https://www.beecrowd.com.br/judge/en/problems/view/1957

import Numeric (showHex)
import Data.Char as C

getInt :: IO Int
getInt = fmap read getLine

main :: IO ()
main = do
    number <- getInt
    putStrLn $ map C.toUpper $ showHex number ""
