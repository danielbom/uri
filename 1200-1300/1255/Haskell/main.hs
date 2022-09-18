import Data.Char
import Data.List
import qualified Data.Map as M

letterFrequency =
    fst
    . foldl' maxFold ([], 0)
    . M.toDescList
    . M.fromListWith (+)
    . map (\ch -> (ch,1))
    . filter isLetter
    . map toLower
    where maxFold (xs, maxVal) (ch, val)
            | maxVal == val = (ch:xs, maxVal)
            | maxVal <  val = ([ch], val)
            | otherwise     = (xs, maxVal)

main = interact
    $ unlines
    . map letterFrequency
    . tail
    . lines

