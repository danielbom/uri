{-# LANGUAGE BangPatterns #-}
-- https://www.beecrowd.com.br/judge/en/problems/view/1963

data Zipper a = Zipper 
  { zLeft :: [a]
  , zRight :: [a]
  }
  deriving Show

zFromList :: [a] -> Zipper a
zFromList xs = Zipper xs []

zToList :: Zipper a -> [a]
zToList (Zipper xs ys) = xs ++ reverse ys

zToLeft :: Zipper a -> Zipper a
zToLeft (Zipper _ []) = error "zToLeft: Zipper left is empty"
zToLeft (Zipper xs (y:ys)) = Zipper (y:xs) ys

zToRight :: Zipper a -> Zipper a
zToRight (Zipper [] _) = error "zToRight: Zipper right is empty"
zToRight (Zipper (x:xs) ys) = Zipper xs (x:ys)

zModify :: a -> Zipper a -> Zipper a
zModify _ (Zipper [] _) = error "zModify: Zipper left is empty"
zModify x (Zipper (_:xs) ys) = Zipper (x:xs) ys

zFocus :: Zipper a -> a
zFocus (Zipper [] _) = error "zFocus: Zipper left is empty"
zFocus (Zipper (x:_) _) = x

readInt :: String -> Int
readInt = read

starTrek :: Zipper Int -> Zipper Int
starTrek z | null $ zLeft z = z
starTrek z
  | x == 0         = z
  | even x         = if null $ zRight z then z1 else let !zn = zToLeft z1 in starTrek zn
  | otherwise      = if null $ zLeft z then z1 else let !zn = zToRight z1 in starTrek zn
  where !x         = zFocus z
        !z1        = zModify (x - 1) z

main :: IO ()
main = do
  _ <- getLine
  stars <- fmap (map readInt . words) getLine
  let !starsResult = zToList . starTrek . zFromList $ stars
  let !starsAttacked = length . filter id $ zipWith (/=) stars starsResult
  let !nonStolenSheeps = sum starsResult
  putStrLn $ show starsAttacked ++ " " ++ show nonStolenSheeps

