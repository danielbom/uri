-- https://www.beecrowd.com.br/judge/en/problems/view/1864

phrase = "LIFE IS NOT A PROBLEM TO BE SOLVED"

main = readLn >>= (putStrLn . (flip take) phrase)
