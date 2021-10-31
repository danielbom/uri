import Data.Time.Format
import Data.Time.Clock
import System.Locale

formatTime' = formatTime defaultTimeLocale

main = do
    line <- getLine
    let dt = readTime defaultTimeLocale "%d/%m/%y" line :: UTCTime
    putStr $ unlines 
        [ formatTime' "%m/%d/%y" dt
        , formatTime' "%y/%m/%d" dt
        , formatTime' "%d-%m-%y" dt
        ]
        
