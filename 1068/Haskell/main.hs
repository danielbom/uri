import qualified Data.ByteString.Char8 as C


parenthesisBalance = valid . C.foldl' countBalance (0, True)
    where countBalance curr@(acc, v) ch
            | v == False = curr
            | ch == '('  = (acc + 1, v)
            | ch == ')'  = (acc - 1, acc > 0)
            | otherwise  = curr
          valid (0, True) = True
          valid (_, _) = False

main = C.interact 
    $ C.unlines
    . map (\line ->  
        if parenthesisBalance line 
            then C.pack "correct"
            else C.pack "incorrect")
    . C.lines
