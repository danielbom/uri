import Control.Applicative
import Text.Printf

getFloat :: IO Float
getFloat = read <$> getLine

getInt :: IO Int
getInt = read <$> getLine

getScore :: IO Float
getScore = do
    x <- getFloat
    if 0.0 <= x && x <= 10.0
        then return x
        else do
            putStrLn "nota invalida"
            getScore

answerToContinue :: IO Bool
answerToContinue = do
    putStrLn "novo calculo (1-sim 2-nao)"
    x <- getInt
    case x of
        1 -> return True
        2 -> return False
        _ -> answerToContinue

main :: IO ()
main = do
    x <- getScore
    y <- getScore
    let average = (x + y) / 2
    printf "media = %.2f\n" average
    continue <- answerToContinue
    if continue
        then main
        else return ()

