-- https://www.urionlinejudge.com.br/judge/en/problems/view/1828

data Winner = First | Second | Draw

bazingaRules = 
  [("scissors", "paper")  -- scissors cuts paper;
  ,("paper", "rock")      -- paper covers rock;
  ,("rock", "lizard")     -- rock crushes lizard;
  ,("lizard", "Spock")    -- lizard poisons Spock;
  ,("Spock", "scissors")  -- Spock smashes scissors;
  ,("scissors", "lizard") -- scissors decapitates lizard;
  ,("lizard", "paper")    -- lizard eats paper;
  ,("paper", "Spock")     -- paper disproves Spock;
  ,("Spock", "rock")      -- Spock vaporizes rock;
  ,("rock", "scissors")   -- rock crushes scissors.
  ]

bazingaWinner move1 move2
  | move1 == move2 = Draw
  | (move1, move2) `elem` bazingaRules = First
  | otherwise = Second 

bazingaReaction sheldon raj = case bazingaWinner sheldon raj of
  Draw -> "De novo!"
  First -> "Bazinga!"
  Second -> "Raj trapaceou!"

translate move = case move of 
  "papel" -> "paper"
  "pedra" -> "rock"
  "lagarto" -> "lizard"
  "tesoura" -> "scissors"
  "Spock" -> "Spock"
  _ -> error "Invalid move"

bazinga i moves = case (map translate . words) moves of 
  [sheldon, raj] -> "Caso #" ++ show i ++ ": " ++ bazingaReaction sheldon raj
  _ -> ""

main = interact (unlines . zipWith bazinga [1..] . tail . lines)
