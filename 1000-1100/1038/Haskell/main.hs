{-# language BangPatterns #-}
import qualified Data.Map as M
import Text.Printf

data Item = Item 
    { itemCode :: !Integer
    , itemName :: !String
    , itemPrice :: !Double
    }

itemsTable = M.fromList $ map (\item -> (itemCode item, item))
    [ Item 1 "Cachorro Quente" 4.0
    , Item 2 "X-Salada" 4.5
    , Item 3 "X-Bacon" 5.0
    , Item 4 "Torrada simples" 2.0
    , Item 5 "Refrigerante" 1.5
    ]

showItem (code:amount:_) = 
    case M.lookup code itemsTable of
        Just item -> printf "Total: R$ %.2f\n" (fromIntegral amount * itemPrice item)
        Nothing -> []
showItem _ = []

main = interact (showItem . map read . words)
