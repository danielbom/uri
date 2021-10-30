import Data.Char
import Data.List
import qualified Data.ByteString.Char8 as C


delimiters = map C.pack ["jogo", "perdi"]

findWin (currMax, currSum) s
    | s `elem` delimiters = (max currMax nextSum, 0)
    | otherwise           = (currMax, nextSum)
    where nextSum = currSum + C.length s

findLoop :: Int -> IO ()
findLoop n | n <= 0 = return ()
findLoop n = do
    C.getLine >>= 
        print
        . fst
        . foldl' findWin (0, 0)
        . map (C.map toLower)
        . C.splitWith (not . isLetter)
    findLoop (n - 1)

main = do
    n <- fmap read getLine
    findLoop n

