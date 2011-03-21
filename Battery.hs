{-
 -  Copyright (c) 2010 Mats Rauhala <mats.rauhala@gmail.com>
 -
 -  Permission is hereby granted, free of charge, to any person
 -  obtaining a copy of this software and associated documentation
 -  files (the "Software"), to deal in the Software without
 -  restriction, including without limitation the rights to use,
 -  copy, modify, merge, publish, distribute, sublicense, and/or sell
 -  copies of the Software, and to permit persons to whom the
 -  Software is furnished to do so, subject to the following
 -  conditions:
 -
 -  The above copyright notice and this permission notice shall be
 -  included in all copies or substantial portions of the Software.
 -
 -  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 -  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 -  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 -  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 -  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 -  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 -  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 -  OTHER DEALINGS IN THE SOFTWARE.
 -}
module Main (main) where

import Control.Monad.Error
import System.IO (hPutStrLn, stderr)
import Color
import Symbols
import Files



barstotal = 10

charging' = Blue [up]
discharging' = Red [down]
full' = Green [koppa]

charging "Charging\n" = charging'
charging "Full\n" = full'
charging _	    = discharging'


warning = 0.1 -- 10%

percent :: Double -> Double -> Double
percent o n = n / o

warn :: Double -> Bool
warn = (>) warning

bar :: Double -> [Color]
bar p = let greens = truncate (p * fromIntegral barstotal) :: Int
	    yellows = barstotal - greens :: Int
	    yellow = if warn p then Red else Yellow
	in [Green (replicate greens barsymbol), yellow (replicate yellows barsymbol)]

printBar = do
    f <- fmap read $ readFileM =<< full
    c <- fmap read $ readFileM =<< charge
    s <- fmap charging $ readFileM =<< status
    return $ termRender s ++ " " ++ cconcat (bar $ percent f c)

main = do
  bar <- runErrorT printBar
  case bar of
    Right x -> putStrLn x
    Left x -> hPutStrLn stderr x
