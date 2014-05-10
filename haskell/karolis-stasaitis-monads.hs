-- Kazkas 1 --
data Kazkas1 a = Kazkas1 a deriving Show

instance Monad Kazkas1 where
    return a = Kazkas1 a
    (Kazkas1 m) >>= f = f m

dosomething a = print a


-- Kazkas 2 --
data Kazkas2 something = Kazkas2 something String deriving Show

instance Monad Kazkas2 where
    return x = Kazkas2 x ""
    (Kazkas2 value str) >>= str2 = 
    	let Kazkas2 value' str' = str2 value in Kazkas2 value' (str ++ str)

duplicate c = Kazkas2 c "B"

-- Kazkas 3 --
data Kazkas3 a = Kazkas3 a Int deriving Show

instance Monad Kazkas3 where
    return x = Kazkas3 x 0
    Kazkas3 x number >>= 
    	f = let Kazkas3 x' number' = (f x) in Kazkas3 x' (2 * number + number')

increase x = Kazkas3 x 1

-- Main --
main = do 
	return (Kazkas1 (Kazkas1 5)) >>= dosomething
	let a = Kazkas2 5 "B" >>= duplicate >>= duplicate >>= duplicate
	print a
	print $ (Kazkas3 2 2) >>= increase >>= increase