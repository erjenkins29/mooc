-- comment line.  Haskell wants users to write as few comments as possible

{-|
  Alternatively, one can do multi-line commenting like this
-}

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x*y*z 

-- |This is a _partially applied function_, since there is still one more 
-- let multByNine = multThree 9 1

divByEight :: (Floating a) => a -> a
divByEight = (/8)  -- this is a partially applied _infix_ function, done by using parentheses. 

-- Note, if trying to view this (or other functions) in ghci, it won't work, since functions are not members of the Show typeclass.

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
 
-- map and filter functions are same as in python
-- e.g ((map (*) [1..4]) !! 2) 5
largestDiv :: (Integral a) => a -> a
largestDiv x = head (filter p [10000, 9999..])
       where p x = x `mod` 3942 == 0

-- takeWhile for filtering on infinite lists
-- takeWhile (<10) [1,3..] returns [1, 3, 5, 7, 9]

-- lambdas are also the same
-- e.g. filter (\ x -> x < 3) [1..20]
--   note however, this is the same as filter (<3) [1..20], (so knowing partial application and currying is important)
--   map (\(a,b)-> a+b) [(1,2), (2,4)]

getFirstWord :: [Char] -> [Char]
getFirstWord = takeWhile (/=' ')

-- using foldl and foldr functions on lists
-- sum' :: (Num a) => a -> a
-- sum' xs = foldl(\acc x -> x + acc) 0 xs

-- or...
sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0
-- NOTE: because of currying, in general if your function is of form f x = g y x, you can rewrite it f = g x 

-- acc doesn't need to be numeric.. can also be binary, list, etc.
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs
-- NOTE: one reason to use foldr over foldl + reverse... foldr can be run on infinite lists, the latter cannot.

-- scan is basically like fold, except the intermediate states are accumulated into a list
-- scan (+) 0 [0,1,2,3,4] returns [0, 0, 1, 3, 6, 10]
-- main use case is for understanding how fold is progressing through states

-- $ operator:
-- separator for convenince, e.g. sum $ filter (<3) [1..10]
-- $ is right-associative, so f $ g $ h x == f(g(h(x)))
-- also.... remember $ is a function itself, so can be used for passing arguments to other functions....
-- map ($ 3) [(1+), (5*)] returns [3, 15]

-- . operator:
-- function composition, e.g. negate . (*3) $ 4 returns -12
-- i.e. map (negate . sum . tail) [[1..4],[4..5],[2..9]]
-- also for writing in 'point-free' style, e.g. converting...
--     fn x = ceiling (negate (tan (cos (max 50 x))))  
-- to...
--     fn = ceiling . negate . tan . cos . max 50
-- Good note on composition:
-- "making long chains of function composition is discouraged, although I plead guilty of sometimes being too composition-happy. The prefered style is to use let bindings to give labels to intermediary results or split the problem into sub-problems and then put it together so that the function makes sense to someone reading it instead of just making a huge composition chain."
-- e.g. with the following function...
--     oddSquareSum :: Integer  
--     oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))     
-- one can write...
--     oddSquareSum :: Integer  
--     oddSquareSum = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]  
-- but for legibility, one _should write...
--     oddSquareSum :: Integer  
--     oddSquareSum =   
--        let oddSquares = filter odd $ map (^2) [1..]  
--            belowLimit = takeWhile (<10000) oddSquares  
--        in  sum belowLimit  
