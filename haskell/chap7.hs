import Data.List


 (nub)
-- or, 
-- import qualified Data.List as M

-- documentation for all modules: www.haskell.org/ghc/docs/latest/html/libraries/

numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub

-- any (<3) [1,2,3]
-- splitAt 3 "heyyou"
-- takeWhile (/=' ') "Welcome to my home town"
-- span, same as takeWhile, only returns the rest of the list (good for finite lists)
-- break, same as span, only the breakpoint occurs on the first instance that the predicate is true
-- dropWhile (<3) [1,2,2,2,3,4,5,4,3,2,1]  
-- sort "This will get sorted"
-- group [1, 1, 1, 1, 1, 2, 3, 3, 3, 4, 4]
-- inits and tails:
-- let w="nihao" in zip (inits w) (tails w)
-- [("","nihao"),("n","ihao"),("ni","hao"),("nih","ao"),("niha","o"),("nihao","")]

-- "box" `isInfixOf` "there's a box over there"
-- "there" `isPrefixOf` "there's a box over there"

-- partition (<3) [1,2,4,3,5]
-- ([1,2],[4,3,5])

-- find (>4) [1,4,7,20]
-- Just 7
-- find (==5) [1,4,7,20]
-- Nothing
-- NOTE: above are of typeclass Maybe, which returns either a value in that type, called Just something, or nothing.

-- 4 `elemIndex` [2,3,4,5]
-- Just 2
-- ' ' `elemIndices` "Where are the spaces"
-- [5,9,13]

-- findIndex (==2) [1,1,4,2]
-- Just 3

-- zip3, zipWith3, zip4, zipWith4 for 3 lists or 4 lists
-- words "hey these           are    the words in this\nsentence"  
-- ["hey","these","are","the","words","in","this","sentence"]  
-- unwords ["ni", "hao"]
-- "ni hao"

-- delete 'h' "ni hao"
-- "ni ao"

-- [1..10] \\ [1,3..9]
-- [2,4,6,8,10]

-- union, intersect
-- sortBy, groupBy
-- sortBy (compare `on` length) [[5,4,5,4,4],[1,2,3],[3,5,4,3],[],[2],[2,2]]

import Data.Char

-- all isAlphaNum "ni hao 123"
-- True

-- map generalCategory " \t\nA9?|"
-- [Space,Control,Control,UppercaseLetter,DecimalNumber,OtherPunctuation,MathSymbol]

import qualified Data.Map as Map
-- for dealing with dictionaries
-- findKey [3] [(3,"nihao"), (4, "lalal")]
-- Just "nihao"

-- Map.insert 3 100 Map.empty
fromList' :: (Ord k) => [(k,v)] -> Map.Map k v  
fromList' = foldr (\(k,v) acc -> Map.insert k v acc) Map.empty

-- fromListWith (for duplicate key handling, allows for a value aggregation)
phoneBookToMap :: (Ord k) => [(k, String)] -> Map.Map k String  
phoneBookToMap xs = Map.fromListWith (\number1 number2 -> number1 ++ ", " ++ number2) xs  

import qualified Data.Set as Set 
-- fromList, difference, union, intersect, map, filter
--  null, size, member, empty, singleton, insert 