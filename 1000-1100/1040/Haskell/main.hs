import Text.Printf

data Score = Approved | Reproved | InExame
    deriving (Eq)

scoreType1 avg 
    | avg >= 7.0 = Approved
    | avg < 5.0  = Reproved
    | otherwise  = InExame

scoreType2 avg 
    | avg < 5.0 = Reproved
    | otherwise = Approved

scoreToStr score = case score of
    Approved -> "Aluno aprovado."
    Reproved -> "Aluno reprovado."
    InExame  -> "Aluno em exame."

showResult (firstLine:xs) =
    let scores = (map read . words $ firstLine) :: [Double]
        weights = [2.0, 3.0, 4.0, 1.0]
        average1 = (sum $ zipWith (*) weights scores) / (sum weights)
        st1 = scoreType1 average1
        exameScore = head $ xs
        average2 = (read exameScore + average1) / 2.0 
        exameMsg = 
            if st1 == InExame && not (null xs)
                then [ "Nota do exame: " ++ exameScore
                     , scoreToStr (scoreType2 average2)
                     , printf "Media final: %.1f" average2
                     ]
                else []
    in  [ printf "Media: %.1f" average1
        , scoreToStr st1
        ] ++ exameMsg
showResult _ = []

main = interact (unlines . showResult . lines)
