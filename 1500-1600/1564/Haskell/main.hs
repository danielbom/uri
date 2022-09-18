-- https://www.beecrowd.com.br/judge/en/problems/view/1564

willHaveCup :: Int -> Bool
willHaveCup x = x > 0

dilmaAnswer :: Bool -> String
dilmaAnswer x = 
  case x of
    True      -> "vai ter duas!"
    otherwise -> "vai ter copa!"

main :: IO ()
main = interact $
  unlines
  . map (dilmaAnswer . willHaveCup . read)
  . lines
