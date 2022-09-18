{-# language BangPatterns #-}
import Control.Monad
import Data.Ord
import Data.Function
import qualified Data.IntMap as IM
import Text.Printf
import qualified Data.List as L


data AppState = AppState 
  { consumptionSum :: !Int
  , populationCount :: !Int
  , properties :: !(IM.IntMap Int)
  }

initialState = AppState 0 0 IM.empty 

updateState !s _ = do
  line <- getLine
  let xs = map read . words $ line
  case xs of
    (residents:comsumption:_) -> do
      let !perResident = comsumption `div` residents 
      return $ AppState 
        (consumptionSum s + comsumption)
        (populationCount s + residents)
        (IM.insertWith (+) perResident residents $ properties s)
    [] -> return s

checkCity :: Int -> IO ()
checkCity !cityCount = do
  n <- readLn

  if n <= 0
    then return ()
    else do
      when (cityCount > 1) (putStrLn "")

      AppState cSum pCount mapProps <- foldM updateState initialState [1..n]
      
      let ps = L.sort $ IM.toList $ mapProps
          _100 = 100 :: Float
          cAvg = fromIntegral (floor ((fromIntegral cSum / fromIntegral pCount) * _100)) / _100
      putStrLn $ printf "Cidade# %d:" cityCount
      putStrLn $ unwords . map (\(k, v) -> printf "%d-%d" v k) $ ps
      putStrLn $ printf "Consumo medio: %.2f m3." cAvg

      checkCity (cityCount + 1)

main = checkCity 1
    

