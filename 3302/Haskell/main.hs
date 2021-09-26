
main = interact (unlines . zipWith answer [1..] . tail . lines)
    where answer i v = "resposta " ++ show i ++ ": " ++ v

