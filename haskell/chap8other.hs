-- Record syntax
--data Person = Person { firstName :: String
--                                      , lastName :: String
 --                                     , age :: Int
--                                      , height :: Float
--                                      , phoneNumber :: String
--                                      } deriving (Show)

-- note: data declarations can be loose, if constraints must be passed they can often be handled in the function definitions
-- note: important that typeclass constraints are not made in data declarations, e.g. data (Ord k) => Map k v = ... the reason is that there's not much added benefit, and we'll have to put similar constraints into every single function we define.

data Vector a = Vector a a a deriving (Show)


vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector a1 b1 c1) `vplus` (Vector a2 b2 c2) = Vector (a1 + a2) (b1 + b2) (c1 + c2)

vmult :: (Num t) => Vector t -> t -> Vector t
(Vector a1 b1 c1) `vmult` d = Vector (a1 * d) (b1 * d) (c1 * d)

smult :: (Num t) => Vector t -> Vector t -> t
(Vector a1 b1 c1) `smult` (Vector a2 b2 c2) = (a1 * a2) + (b1 * b2) + (c1 * c2)

data Person = Person { firstName :: String
                                      , lastName :: String
                                      , age :: Int
                                      } deriving (Eq, Show, Read)

-- note: if specifying data that is deriving typeclass Ord, leftmost value constructors are less than those to the right

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday  
                    deriving (Show, Read, Eq, Ord, Bounded, Enum)

-- type synonyms... e.g.
-- type String = [Char]
-- type PhoneBook = [(String, String)]
type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]

-- Now, if we're defining phonebook specific functions, the type declaration is better looking
inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name, pnumber) `elem` pbook

-- using Either type, to get more info on why something failed, instead of Maybe, which gives only the result of failure
data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show) 

--import qualified Data.Map as Map  
  
--data LockerState = Taken | Free deriving (Show, Eq)  
--type Code = String  
--type LockerMap = Map.Map Int (LockerState, Code)

--lockerLookup :: Int -> LockerMap -> Either String Code  
--lockerLookup lockerNumber map =   
--    case Map.lookup lockerNumber map of   
--        Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"  
--        Just (state, code) -> if state /= Taken   
--                                then Right code  
--                                else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"  

-- recursive type definition
infixr 5 :-:
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x (EmptyTree) = singleton x
treeInsert x (Node a left right)
     | x == a = Node x left right
     | x < a    = Node a (treeInsert x left) right
     | x > a    = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x > a    = treeElem x right
    | x < a    = treeElem x left

--let nums = [8,6,4,1,7,3,5]  
--let numsTree = foldr treeInsert EmptyTree nums

--minimal complete definition -- minimum of functions required so that types of that typeclass act as advertised
--class Eq a where
--   (==) :: a -> a -> Bool
--    (/=) :: a -> a -> Bool
--    x == y = not (x /= y)
--    x /= y = not (x == y)

-- no need to add the "deriving" piece, since we will define those instances below
data TrafficLight = Red | Yellow | Green -- deriving (Eq, Ord, Show, Read)

instance Eq TrafficLight where  
    Red == Red = True  
    Green == Green = True  
    Yellow == Yellow = True  
    _ == _ = False

instance Show TrafficLight where 
    show Red = "Red Light"
    show Green = "Green Light"
    show Yellow = "Yellow Light"

-- subclassing: example for num class
--class (Eq a) => Num a where ...

-- Functor class
instance Functor Tree where
   fmap f EmptyTree = EmptyTree
   fmap f (Node a left right) = Node (f a) (fmap f left) (fmap f right)


