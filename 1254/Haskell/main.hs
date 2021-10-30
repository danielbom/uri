import Control.Applicative hiding (many) 
import Control.Monad (mapM)
import Data.Char
import Text.ParserCombinators.ReadP


charI c = choice [char (toLower c), char (toUpper c)]
stringI s = mapM charI s

anyP = many $ satisfy (const True)
tagP = char '<' *> many (satisfy (`notElem` "<>")) <* char '>'
parseP = (,) <$> anyP <*> tagP
patternP p = (,) <$> anyP <*> stringI p

transformP :: (a -> String) -> ReadP a -> String -> String
transformP f p [] = []
transformP f p xs =
    case readP_to_S p xs of
        []               -> xs
        ((item, rest):_) -> f item ++ transformP f p rest

tagReplacement :: String -> String -> String -> String
tagReplacement pattern replacement tag = 
    transformP repl (patternP pattern) tag
    where repl (start, _) = start ++ replacement

lineReplacement :: [String] -> [String]
lineReplacement (pattern:replacement:line:rest) =
    transformP replace parseP line:lineReplacement rest
    where replace (start, tag) = 
            start ++ "<"  ++ tagReplacement pattern replacement tag ++ ">"
lineReplacement _ = []

main = interact
    $ unlines
    . lineReplacement
    . lines
