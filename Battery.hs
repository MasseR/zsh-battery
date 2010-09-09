module Main (main) where

import Color
import Symbols
import Files



barstotal = 10

charging' = Blue up
discharging' = Red down
full' = Green koppa

charging "Charging\n" = charging'
charging "Full\n" = full'
charging _	    = discharging'


warning = 0.1 -- 10%


percent :: Double -> Double -> Double
percent o n = n / o

warn :: Double -> Bool
warn = (>) warning

bar :: Double -> [Color]
bar p = let greens = truncate (p * (fromIntegral barstotal)) :: Int
	    yellows = barstotal - greens :: Int
	    yellow = if warn p then Red else Yellow
	in (replicate greens (Green barsymbol)) ++ (replicate yellows (yellow barsymbol))

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
