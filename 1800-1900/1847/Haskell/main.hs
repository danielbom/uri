happy = ":)"
sad = ":("

main = do
    line <- getLine
    let [t1, t2, t3] = map read $ words line
        s1 = t2 - t1
        s2 = t3 - t2
        mood = if s1 < 0
                then if s2 >= 0 || s2 > s1 then happy else sad
                else if s2 <= 0 || s1 > s2 then sad else happy 
    putStrLn mood

