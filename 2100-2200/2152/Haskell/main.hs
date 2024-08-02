import Text.Printf (printf)

type Log = (Int, Int, Int)

display :: Log -> String
display (hour, minute, opened) = showTime hour ++ ":" ++ showTime minute ++ " - A porta " ++ isOpened ++ "!"
    where isOpened = if opened == 1 then "abriu" else "fechou"
          showTime = printf "%02d"

parse :: String -> Log
parse input = (hour, minute, opened)
    where [hour, minute, opened] = map read $ words input

main :: IO ()
main = interact
    $ unlines
    . map (display . parse)
    . tail
    . lines 
