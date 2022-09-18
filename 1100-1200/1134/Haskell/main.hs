import Data.List

countFuel acc@(alcohol, gasoline, diesel) x
    | x == 1 = (alcohol + 1, gasoline, diesel)
    | x == 2 = (alcohol, gasoline + 1, diesel)
    | x == 3 = (alcohol, gasoline, diesel + 1)
    | otherwise = acc

makeMessage (alcohol, gasoline, diesel) =
    [ "MUITO OBRIGADO"
    , "Alcool: " ++ show alcohol
    , "Gasolina: " ++ show gasoline
    , "Diesel: " ++ show diesel
    ]

main = interact
    $ unlines
    . makeMessage
    . foldl' countFuel (0, 0, 0)
    . takeWhile (/=4)
    . filter (\x -> 0 < x && x <= 4)
    . map read
    . lines
