import qualified Data.Set as Set
import qualified Data.ByteString.Char8 as C


main = C.interact
    $ C.pack
    . (\n -> "Falta(m) " ++ show (151 - n) ++ " pomekon(s).\n")
    . Set.size
    . Set.fromList
    . tail
    . C.lines
