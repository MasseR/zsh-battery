module Main (main) where

import Color
import System.Directory (doesFileExist)
import System.FilePath
import Control.Monad (forM)

barsymbol = "▶"
up = "↑"
down = "↓"

batterydir = "/sys/class/power_supply/BAT1"
full = batterydir </> "charge_full"
charge = batterydir </> "charge_now"
status = batterydir </> "status"

barstotal = 10

charging' = Blue up
discharging' = Red down
full' = Green "-"

charging "Charging\n" = charging'
charging "Full\n" = full'
charging _	    = discharging'


warning = 0.1 -- 10%

filesExist :: IO Bool
filesExist = do
		let f = [full, charge, status]
		t <- forM f doesFileExist
		return $ all id t

percent :: Double -> Double -> Double
percent o n = n / o

warn :: Double -> Bool
warn = (>) warning

bar :: Double -> [Color]
bar p = let green = truncate (p * (fromIntegral barstotal)) :: Int
	    yellow = barstotal - green :: Int
	in (replicate green (Green barsymbol)) ++ (replicate yellow (Yellow barsymbol))

printBar = do
    f <- readFile full >>= return . read
    c <- readFile charge >>= return . read
    s <- readFile status >>= return . charging
    putStrLn $ render s ++ " " ++ cconcat (bar $ percent f c)
    
main = do
    e <- filesExist
    case e of
	False -> putStrLn "No can do, no such files. Is battery connected?"
	True -> printBar
