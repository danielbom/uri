{-# language BangPatterns #-}

data Stats = Stats 
    { positives :: !Integer
    , negatives :: !Integer
    , odds :: !Integer
    , evens :: !Integer
    }

(Stats p1 n1 o1 e1) `statsConcat` (Stats p2 n2 o2 e2) =
     Stats (p1+p2) (n1+n2) (o1+o2) (e1+e2)

statsEmpty = Stats 0 0 0 0

statsFromNumber n
    | n == 0    = statsEmpty { evens = 1 } 
    | n > 0     = if even n then Stats 1 0 0 1 else Stats 1 0 1 0
    | otherwise = if even n then Stats 0 1 0 1 else Stats 0 1 1 0

showStats stats = unlines 
    [ show (evens stats) ++ " valor(es) par(es)"
    , show (odds stats) ++ " valor(es) impar(es)" 
    , show (positives stats) ++ " valor(es) positivo(s)"
    , show (negatives stats) ++ " valor(es) negativo(s)"
    , ""
    ]

main = interact (showStats . foldr (statsConcat . statsFromNumber) statsEmpty . map read . lines)
        
