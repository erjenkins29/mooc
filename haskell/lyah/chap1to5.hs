doubleMe x = x + x

removeLowers :: [Char] -> [Char]
removeLowers st = [ c | c<-st , c `elem` ['A'..'Z']]

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, ou're out of luck"

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial(n-1)

addVecs :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVecs (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

third :: (a,b,c) -> c
third (_, _, z) = z

head' :: [a] -> a
head' [] = error "nope"
head' (x:_) = x 

length' :: (Num b) => [a] -> b 
length' [] = 0
length' (_:xs) = 1 + length' xs

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
  | bmi <= skinny = "Not good"
  | bmi <= medium = "Nihao gx"
  | otherwise   = "Very good"
  where bmi = weight / height ^ 2
        skinny = 18.5
        medium = 29.0 

max' :: (Ord a) => a -> a -> a
max' a b | a > b = a | otherwise = b 

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x: replicate' (n-1) x

take' :: (Integral i) => i -> [a] -> [a]
take' n _ 
    | n <= 0   = []
take' _ []     = []
take' n (x:xs) = x:(take' (n-1) xs) 
