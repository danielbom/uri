import Data.List
import Data.Function

main = interact 
    $ unlines
    . map (concat . intersperse ", ")
    . transpose
    . groupBy ((==) `on` length)
    . sortBy (compare `on` length)
    . tail
    . lines
