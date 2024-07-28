timezoneAdjust :: String -> String
timezoneAdjust s =
    let [ departureTime          -- [0..24]
         , travelTime            -- [0..12]
         , destinationTimeZone   -- [-5..5]
         ] = (map read $ words s) :: [Int]
    in show $ (departureTime + travelTime + destinationTimeZone) `mod` 24

main :: IO ()
main = getLine >>= putStrLn . timezoneAdjust
