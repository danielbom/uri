import Data.List

takeUntil :: (Eq a) => a -> [a] -> [a]
takeUntil _ [] = []
takeUntil elem (x:xs)
    | x == elem = [x]
    | otherwise = x:takeUntil elem xs

main = interact
    $ unlines
    . map (\line -> case line of
        "2002" -> "Acesso Permitido"
        _      -> "Senha Invalida"
    )
    . takeUntil "2002"
    . lines

