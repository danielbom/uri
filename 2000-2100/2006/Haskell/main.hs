-- https://www.urionlinejudge.com.br/judge/en/problems/view/2006

count x = length . filter (==x)

main = do
  x <- getLine 
  xs <- getLine
  print $ count x (words xs)
