-- https://www.beecrowd.com.br/judge/en/problems/view/1983

import Text.Printf as P
import Data.List as L

type Order = (Int, Int)

productPrices = 
  [ (1001 , 1.50)
  , (1002 , 2.50)
  , (1003 , 3.50)
  , (1004 , 4.50)
  , (1005 , 5.50)
  ]

readOrder :: String -> Order
readOrder line = (read productId, read orderQuantity)
  where [productId, orderQuantity] = words line

computePrice :: Order -> Double
computePrice (productId, orderQuantity) = productPrice * fromIntegral orderQuantity
  where productPrice = snd . head . filter ((==productId) . fst) $ productPrices

main :: IO ()
main = interact
  $ printf "%.2f\n"
  . L.foldl' (+) 0.0
  . map (computePrice . readOrder)
  . tail
  . lines
