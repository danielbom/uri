import Data.Maybe
import Data.Traversable
import qualified Data.Set as S
import qualified Data.Map.Strict as M


type Point = (Int, Int)

groupIn :: Int -> [a] -> [[a]]
groupIn _ [] = []
groupIn n ps = take n ps: groupIn n (drop n ps)

pointPositions :: M.Map String Point
pointPositions = 
    M.fromList [([row,col], (i, j)) | (i, row) <- rows, (j, col) <- cols]
    where rows = zip [1..] ['1'..'8']
          cols = zip [1..] ['a'..'h']

positionToPoint :: String -> Maybe Point
positionToPoint = flip M.lookup pointPositions

pawnAttack :: Point -> [Point]
pawnAttack (row, col) = [(row - 1, col + 1), (row - 1, col - 1)]

knightMoves :: [Point]
knightMoves = kMovesVertical ++ kMovesHorizontal 
    where kMovesTop = [(1, 2), (-1, 2)]
          kMovesDown = [(i, -j) | (i, j) <- kMovesTop]
          kMovesVertical = kMovesTop ++ kMovesDown
          kMovesHorizontal = [(j, i) | (i, j) <- kMovesVertical]

knightAttack :: Point -> [Point]
knightAttack (row, col) = 
    [(row', col') | (i, j) <- knightMoves,
                    let row' = row + i,
                    let col' = col + j,
                    row' > 0 && col' > 0 && row' < 9 && col' < 9]

checkKnightScape :: [Point] -> Int
checkKnightScape (k:ps) = S.size (kas `S.difference` pas)
    where kas = S.fromList (knightAttack k)
          pas = S.fromList (concatMap pawnAttack ps)

knightScape :: (Int, [String]) -> String
knightScape (i, ps) = 
    maybe "" messagePoints
    $ fmap checkKnightScape
    $ traverse positionToPoint ps
    where messagePoints n = "Caso de Teste #" ++ show i ++ ": " ++ show n ++ " movimento(s)."

main = interact 
    $ unlines
    . takeWhile (not . null)
    . map knightScape
    . zip [1..]
    . groupIn 9
    . lines
