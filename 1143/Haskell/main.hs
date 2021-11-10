import Control.Applicative

squaredAndCubic x = [x, x2, x3]
    where x2 = x * x
          x3 = x2 * x

main = getLine >>= 
    putStr
    . unlines
    . map (unwords . map show . squaredAndCubic) 
    . (\x -> [1..x]) 
    . read

