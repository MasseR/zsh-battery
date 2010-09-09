module Files where

import System.Directory (doesFileExist)
import System.FilePath
import Control.Monad (forM)

filesExist :: IO Bool
filesExist = do
		let f = [full, charge, status]
		t <- forM f doesFileExist
		return $ all id t

batterydir = "/sys/class/power_supply/BAT1"
full = batterydir </> "charge_full"
charge = batterydir </> "charge_now"
status = batterydir </> "status"
