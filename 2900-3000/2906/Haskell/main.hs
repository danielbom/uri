import qualified Data.Set as S
import Data.Function
import Data.Ord
import Data.List

data Email = Email
    { emailOriginal :: String
    , emailUnique :: String
    }

instance Eq Email where
    (==) = (==) `on` emailUnique

instance Ord Email where
    (<=) = (<=) `on` emailUnique

mkEmail :: String -> Email
mkEmail text = Email text uniqueText
    where (localPart, provider) = span (/='@') text
          localPart' = filter (/='.') . takeWhile (/='+') $ localPart
          uniqueText = localPart' ++ provider

main = interact
    $ (++ "\n")
    . show
    . S.size
    . S.fromList
    . map mkEmail
    . tail
    . lines
