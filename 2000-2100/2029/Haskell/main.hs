import Text.Printf (printf)

pi' = 3.14

processLines :: [String] -> [String]
processLines [] = []
processLines (volume:diameter:rest) = 
    let volume' = read volume :: Double
        diameter' = read diameter :: Double
        radius = diameter' / 2
        area = pi' * radius * radius
        height = volume' / area
        showHeight = printf "ALTURA = %.2f" height
        showArea = printf "AREA = %.2f" area
    in  showHeight : showArea : processLines rest

main :: IO ()
main = interact $ unlines . processLines . lines
