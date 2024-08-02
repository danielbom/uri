type Bonus = Int
type Player = (Int, Int, Int)
type Game = (Bonus, Player, Player)

readPlayer :: String -> Player
readPlayer line = (attack, defense, level)
    where [attack, defense, level] = map read $ words line

parse :: [String] -> [Game]
parse (bonus:player1:player2:rest) = (read bonus, readPlayer player1, readPlayer player2):parse rest
parse _ = []

computeAttack :: Player -> Bonus -> Double
computeAttack (attack, defense, level) bonus = baseAttack + bonusAttack
    where baseAttack = fromIntegral (attack + defense) / 2.0
          bonusAttack = fromIntegral $ if even level then bonus else 0

process :: Game -> Int
process (bonus, player1, player2)
    | attack1 > attack2 = 1
    | attack1 < attack2 = 2
    | otherwise         = 0
    where attack1 = computeAttack player1 bonus
          attack2 = computeAttack player2 bonus

display :: Int -> String
display 0 = "Empate"
display 1 = "Dabriel"
display 2 = "Guarte"
display _ = error "Unexpected result"

main :: IO ()
main = interact
    $ unlines
    . map (display . process)
    . parse
    . tail
    . lines
