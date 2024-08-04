data Action 
    = ActionClick
    | ActionClose

parse :: String -> Action
parse "fechou" = ActionClose
parse "clicou" = ActionClick
parse action = error $ "Unknown action to parse: " ++ action

process :: Int -> [Action] -> Int
process numberOfTabs [] = numberOfTabs
process numberOfTabs (action:rest) = process newNumberOfTabs rest
    where newNumberOfTabs = case action of
            ActionClose -> numberOfTabs + 1
            ActionClick -> numberOfTabs - 1

display :: Int -> String
display = show

main :: IO ()
main = do
    line <- getLine
    let [initialNumberOfTabs, numberOfActions] = map read $ words line :: [Int]
    lines <- mapM (\_ -> getLine) [1..numberOfActions]
    putStrLn . display . process initialNumberOfTabs . map parse $ lines
