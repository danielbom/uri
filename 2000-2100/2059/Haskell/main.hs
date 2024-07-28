oddEvenCheating :: String -> String 
oddEvenCheating input =
    -- 0 <= playerOneIsEven, playerOneIsCheating, playerTwoAccusedCheating <= 1 :: Bool
    -- 1 <= playerOneNumber, playerTwoNumber <= 100
    let [ playerOneIsEven
         , playerOneNumber
         , playerTwoNumber
         , playerOneIsCheating
         , playerTwoAccusedCheating
         ] = (map read $ words input) :: [Int]
        winner = if playerOneIsCheating == 1 && playerTwoAccusedCheating == 1
            then 2
            else if playerOneIsCheating == 1 && playerTwoAccusedCheating == 0
            then 1
            else if playerOneIsCheating == 0 && playerTwoAccusedCheating == 1
            then 1
            else -- if playerOneIsCheating == 0 && playerTwoAccusedCheating == 0
                if even $ playerOneNumber + playerTwoNumber
                then if playerOneIsEven == 1 then 1 else 2
                else if playerOneIsEven == 1 then 2 else 1
    in "Jogador " ++ show winner ++ " ganha!"

main :: IO ()
main = getLine >>= putStrLn . oddEvenCheating
