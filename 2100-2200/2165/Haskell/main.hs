display :: Bool -> String
display True = "TWEET"
display False = "MUTE"

process :: String -> Bool
process = (<=140) . length

main :: IO ()
main = getLine >>=
    putStrLn
    . display
    . process
