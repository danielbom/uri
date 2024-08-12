parse :: [String] -> [(String, String)]
parse (x:y:xs) = (x, y):parse xs
parse _ = []

process :: (String, String) -> (Int, Int)
process (pat0, text0) = go0 0 text0 0 0
    where go0 i text count ix
            | null text = (count, ix)
            | otherwise = go i pat0 text (tail text) (i + 1) count ix
          
          go i pat text nextText nextI count ix
            | null pat  = go0 i text (count + 1) nextI
            | null text = (count, ix)
            | otherwise = 
                if head text /= head pat
                    then go0 nextI nextText count ix
                    else go (i + 1) (tail pat) (tail text) nextText nextI count ix

display :: (Int, (Int, Int)) -> String
display (ix, (0, _)) = unlines
    [ "Caso #" ++ show ix ++ ":"
    , "Nao existe subsequencia"
    ]
display (ix, (count, pos)) = unlines 
    [ "Caso #" ++ show ix ++ ":"
    , "Qtd.Subsequencias: " ++ show count
    , "Pos: " ++ show pos
    ]

main :: IO ()
main = interact
    $ unlines
    . map display
    . zip [1..]
    . map process
    . parse
    . lines
