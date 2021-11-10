import Control.Applicative
import Text.Printf

getScore :: IO (Int, Int)
getScore = do
    [x, y] <- map read . words <$> getLine
    return (x, y)

computeGrenais :: Int -> Int -> Int -> IO (Int, Int, Int)
computeGrenais winsInter winsGremio totalGames = do
    (goalsInter, goalsGremio) <- getScore
    putStrLn "Novo grenal (1-sim 2-nao)"
    let (winsInter', winsGremio') 
            | goalsInter > goalsGremio = (winsInter + 1, winsGremio)
            | goalsInter < goalsGremio = (winsInter, winsGremio + 1)
            | otherwise = (winsInter, winsGremio)
    let totalGames' = totalGames + 1
    continue <- getLine
    case continue of
        "1" -> computeGrenais winsInter' winsGremio' totalGames'
        "2" -> return (winsInter', winsGremio', totalGames')
        _   -> error "Invalid input"

main = do
    (winsInter, winsGremio, totalGames) <- computeGrenais 0 0 0
    let dessine = totalGames - winsInter - winsGremio
    printf "%d grenais\n" totalGames
    printf "Inter:%d\n" winsInter
    printf "Gremio:%d\n" winsGremio
    printf "Empates:%d\n" dessine

    if winsInter > winsGremio
        then putStrLn "Inter venceu mais"
        else if winsInter < winsGremio
            then putStrLn "Gremio venceu mais"
            else putStrLn "Nao houve vencedor"



