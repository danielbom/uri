-- https://www.beecrowd.com.br/judge/en/problems/view/2510

main :: IO ()
main = interact
    $ unlines
    . map (const "Y")
    . tail
    . lines
