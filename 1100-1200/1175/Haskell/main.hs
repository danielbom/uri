-- https://www.urionlinejudge.com.br/judge/en/problems/view/1075
import Text.Printf

nthy :: Integer -> String -> String
nthy = printf "N[%d] = %s"

main = interact (unlines . zipWith nthy [0..] . reverse . lines)
