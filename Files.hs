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
module Files where

import System.Directory (doesFileExist, getDirectoryContents)
import System.FilePath
import Control.Monad (forM)
import Control.Monad.Error
import Data.List (isPrefixOf)

batterydir ::  FilePath
batterydir = "/sys/class/power_supply/"

batteryfile :: ErrorT String IO FilePath
batteryfile = do
  all <- liftIO $ getDirectoryContents batterydir
  case filter (("BAT" `isPrefixOf`)) all of
       [] -> throwError "No batteries present"
       (x:_) -> return x

full ::  ErrorT String IO FilePath
full = (</> "charge_full") `fmap` batteryfile

charge ::  ErrorT String IO FilePath
charge = (</> "charge_now") `fmap` batteryfile

status ::  ErrorT String IO FilePath
status = (</> "status") `fmap` batteryfile

readFileM :: FilePath -> ErrorT String IO String
readFileM = liftIO . readFile
