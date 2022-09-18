-- https://www.beecrowd.com.br/judge/en/problems/view/1865

data Hero = Hero
  { heroName :: String
  , heroPower :: Integer
  }

readHero :: String -> Hero
readHero line = case words line of
  [name, power] -> Hero name (read power)
  _             -> error $ "Invalid hero: " ++ line

heroRaiseMjolnir :: Hero -> Bool
heroRaiseMjolnir hero = heroName hero == "Thor"

sayIfHeroRaiseMjolnir :: Hero -> String
sayIfHeroRaiseMjolnir hero =
  if heroRaiseMjolnir hero 
  then "Y"
  else "N"

main = interact
  $ unlines
  . map (sayIfHeroRaiseMjolnir . readHero)
  . tail
  . lines
