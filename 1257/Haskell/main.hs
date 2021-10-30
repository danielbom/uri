import Control.Monad
import Data.List
import Data.Char


getNLines :: Int -> IO [String]
getNLines n | n <= 0 = return []
getNLines n = do
    line <- getLine
    rest <- getNLines (n-1)
    return (line:rest)
    
loopArrayHash :: Int -> IO ()
loopArrayHash n | n <= 0 = return ()
loopArrayHash n = do
    let a = ord 'A'
        ord' ch = ord ch - a
    getLine 
        >>= getNLines . read
        >>= print 
            . sum 
            . zipWith
            (\i xs -> sum $ zipWith (\j ch -> i + j + ord' ch) [0..] xs)
            [0..]
    loopArrayHash (n - 1)

main = do
    n <- fmap read getLine
    loopArrayHash n

