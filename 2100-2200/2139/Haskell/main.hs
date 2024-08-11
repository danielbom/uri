type Date = (Int, Int)

data ChristmasRelation
    = ChristmasDay
    | ChristmasEve
    | ChristmasGone
    | ChristmasIn Int

parse :: String -> Date
parse line = (month, day)
    where [month, day] = map read $ words line

-- https://www.timeanddate.com/calendar/months/
daysInMonths :: [Int]
daysInMonths = 
    [ 31 -- days in January
    , 29 -- days in February (28 in a common year and 29 days in leap years)
    , 31 -- days in March
    , 30 -- days in April
    , 31 -- days in May
    , 30 -- days in June
    , 31 -- days in July
    , 31 -- days in August
    , 30 -- days in September
    , 31 -- days in October
    , 30 -- days in November
    , 31 -- days in December
    ]

process :: Date -> ChristmasRelation
process (12, day)
    | day >  25 = ChristmasGone
    | day == 25 = ChristmasDay
    | day == 24 = ChristmasEve
    | otherwise = ChristmasIn day
process (month, day) = ChristmasIn (daysToEndMonth + restMonthsDays - decemberDays + christmasDay)
    where monthDays = daysInMonths !! (month - 1)
          daysToEndMonth = monthDays - day
          decemberDays = 31
          christmasDay = 25
          restMonthsDays = sum . map fst . filter ((>month) . snd) $ zip daysInMonths [1..]

display :: ChristmasRelation -> String
display christmas = case christmas of
    ChristmasGone -> "Ja passou!"
    ChristmasDay  -> "E natal!"
    ChristmasEve  -> "E vespera de natal!"
    ChristmasIn d -> "Faltam " ++ show d ++ " dias para o natal!"

main :: IO ()
main = interact
    $ unlines
    . map (display . process . parse)
    . lines
