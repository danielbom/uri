import Control.Monad
import Data.Ord
import Data.Function
import qualified Data.Map as M
import Text.Printf
import qualified Data.List as L


data AppState = AppState 
  { consumptionSum :: Integer
  , populationCount :: Integer
  , properties :: [(Integer, Integer)]
  }

initialState = AppState 0 0 []

updateState s _ = do
  line <- getLine
  let xs = map read . words $ line
  case xs of
    (residents:comsumption:_) -> do
      let perResident = comsumption `div` residents 
      return $ AppState 
        (consumptionSum s + comsumption)
        (populationCount s + residents)
        ((perResident, residents):properties s)
    [] -> return s

checkCity cityCount = do
  n <- readLn

  if n <= 0
    then return ()
    else do
      when (cityCount > 1) (putStrLn "")

      readState <- foldM updateState initialState [1..n]
      
      let mapProperties = M.fromListWith (+) $ properties readState
          ps = L.sortBy (compare `on` fst) $ M.toList $ mapProperties
          pCount = fromIntegral $ populationCount readState
          cSum = fromIntegral $ consumptionSum readState
          cAvg = fromIntegral (floor (((cSum / pCount) :: Float) * 100.0)) / (100.0 :: Float)
      putStrLn $ "Cidade# " ++ show cityCount ++ ":"
      putStrLn $ unwords . map (\(k, v) -> show v ++ "-" ++ show k) $ ps
      putStrLn $ printf "Consumo medio: %.2f m3." cAvg

      checkCity (cityCount + 1)

main = checkCity 1
    

