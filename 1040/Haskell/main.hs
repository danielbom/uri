import Text.Printf

data Score = Approved | Reproved | InExame

scoreType1 avg  
    | avg >= 7.0 = Approved
    | avg < 5.0  = Reproved
    | otherwise  = InExame

scoreType2 avg 
    | avg < 5.0 = Reproved
    | otherwise = Approved

showResult (firstLine:xs) =
    case scores of
        (s1:s2:s3:s4) -> unlines $
            [printf "Media: %.1f" average1] ++
            case scoreType1 average1 of
                Approved -> ["Aluno aprovado."]
                Reproved -> ["Aluno reprovado."]
                InExame  ->
                    case xs of
                        [exameScore] -> 
                            [ "Aluno em exame."
                            , "Nota do exame: " ++ exameScore
                            ] ++
                            case scoreType2 average2 of
                                Approved -> ["Aluno aprovado.", finalScoreText]
                                Reproved -> ["Aluno reprovado.", finalScoreText]
                            where average2 = (read exameScore + average1) / 2.0 
                                  finalScoreText = printf "Media final: %.1f" average2
                        _ -> ["Aluno reprovado."]
        _ -> []
    where scores = (map read . words $ firstLine) :: [Double]
          weights = [2.0, 3.0, 4.0, 1.0]
          average1 = (sum $ zipWith (*) weights scores) / (sum weights)
showResult _ = []

main = interact (showResult . lines)
