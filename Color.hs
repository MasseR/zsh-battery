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
    render (Black s) = "\o033[0;30m" ++ s ++ "\o33[0m"
    render (Red s) = "\o033[0;31m" ++ s ++ "\o33[0m"
    render (Green s) = "\o033[0;32m" ++ s ++ "\o33[0m"
    render (Brown s) = "\o033[0;33m" ++ s ++ "\o33[0m"
    render (Yellow s) = "\o033[1;33m" ++ s ++ "\o33[0m"
    render (Blue s) = "\o033[0;34m" ++ s ++ "\o33[0m"
    render (Purple s) = "\o033[0;35m" ++ s ++ "\o33[0m"

class CColor a where
    render :: a -> String
    cconcat :: [a] -> String
    cconcat = concat . map render 

