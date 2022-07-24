-- https://www.beecrowd.com.br/judge/en/problems/view/2031

chunksOf n [] = []
chunksOf n xs = 
    let (first, rest) = splitAt n xs
    in first : chunksOf n rest

-- Rock, Paper, Airstrike
play [player1, player2] = case (player1, player2) of 
  ("papel" , "papel")  -> "Ambos venceram"
  ("pedra" , "pedra")  -> "Sem ganhador"
  ("pedra" , "papel")  -> "Jogador 1 venceu"
  ("papel" , "pedra")  -> "Jogador 2 venceu"
  ("ataque", "ataque") -> "Aniquilacao mutua"
  ("ataque", _)        -> "Jogador 1 venceu"
  (_       , "ataque") -> "Jogador 2 venceu"


main = interact $
  unlines .
  map play .
  chunksOf 2 .
  tail .
  lines
