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
module Color
    ( Color(..),
      CColor(render, cconcat)
    )
where

data Color = Blue String |
	     Red String |
	     Black String |
	     Green String |
	     Brown String |
	     Purple String |
	     LightGray String |
	     DarkGray String |
	     LightBlue String |
	     LightGreen String |
	     LightCyan String |
	     LightRed String |
	     LightPurple String |
	     Yellow String |
	     White String
    deriving (Show)

instance CColor Color where
    render (Black s)  = "%{\o033[0;30m%}" ++ s ++ "%{\o33[0;0m%}"
    render (Red s)    = "%{\o033[0;31m%}" ++ s ++ "%{\o33[0;0m%}"
    render (Green s)  = "%{\o033[0;32m%}" ++ s ++ "%{\o33[0;0m%}"
    render (Brown s)  = "%{\o033[0;33m%}" ++ s ++ "%{\o33[0;0m%}"
    render (Yellow s) = "%{\o033[1;33m%}" ++ s ++ "%{\o33[0;0m%}"
    render (Blue s)   = "%{\o033[0;34m%}" ++ s ++ "%{\o33[0;0m%}"
    render (Purple s) = "%{\o033[0;35m%}" ++ s ++ "%{\o33[0;0m%}"

class CColor a where
    render :: a -> String
    cconcat :: [a] -> String
    cconcat = concat . map render 

