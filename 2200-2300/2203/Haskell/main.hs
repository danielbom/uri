type State = (Int, Int, Int, Int, Int, Int, Int)

parse :: String -> State
parse line = (xf, yf, xi, yi, vi, r1, r2)
    where [xf, yf, xi, yi, vi, r1, r2] = map read $ words line

timeFiddlestickUltimate :: Double
timeFiddlestickUltimate = 1.5 -- seconds

process :: State -> Bool
process (xFiddlestick, yFiddlestick, xInvader, yInvader, velocityInvader, radiusFiddlestickUltimate, radiusFiddlestickFlight) = 
    let distanceInitial = sqrt $ fromIntegral $ (xFiddlestick - xInvader) ^ 2 + (yFiddlestick - yInvader) ^ 2
        distanceMoved = timeFiddlestickUltimate * (fromIntegral velocityInvader)
        distanceTotal = distanceInitial + distanceMoved
        radiusTotal = fromIntegral $ radiusFiddlestickUltimate + radiusFiddlestickFlight
    in distanceTotal <= radiusTotal

display :: Bool -> String
display True = "Y"
display False = "N"

main = interact
    $ unlines
    . map (display . process . parse)
    . lines
