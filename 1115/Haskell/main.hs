-- https://www.urionlinejudge.com.br/judge/en/problems/view/1000

quadrant :: [String] -> String
quadrant [x, y] =
  case (read x > 0, read y > 0) of
    (True, True) -> "primeiro"
    (False, True) -> "segundo"
    (False, False) -> "terceiro"
    (True, False) -> "quarto"
quadrant _ = ""

main = interact $ unlines . map quadrant . takeWhile (notElem "0") . map words . lines
