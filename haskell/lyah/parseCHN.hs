type WordSize = Int       -- Number of chars in word
type WordFreq = Int       -- Number of instances
type WordInfo = (WordSize, WordFreq)

data Node a = EndStr | Node a deriving (Show)

type WordPath = [ Node WordInfo ]  -- Trying to optimize this.  Second Int is the path aggregator.  Third Int is the # of letters
type CharPath = [ (Node WordInfo, Int, Int) ]  -- For creating paths.  Second Int is end of word if ==0
type Position = [ Node WordInfo ]  -- This is the array of n-gram countss
type WordGraph = [ Position ]

-- The below functions is used for adjusting the segments
getVal :: Node WordInfo -> Int
getVal (Node (a,b)) = a
getVal EndStr = 0

getFreq :: Node WordInfo -> Int
getFreq (Node (a,b)) = b
getFreq EndStr = 0

aggWordFreqs :: Int -> WordInfo -> Int
aggWordFreqs a (n,s) = let getWeights = foldl (*) 1 $ replicate (n-1) 3
                           applyWeights = s*getWeights
                       in  a + applyWeights

testNewConn :: CharPath -> Node WordInfo -> CharPath
--testNewConn cp@((w, b, agg):_) EndStr = (w, b-1, agg):cp  -- Do nothing at the EndStr
--testNewConn cp@((EndStr, _, agg):_) (Node wi) = (Node wi, (fst wi) -1, agg):cp  -- Do nothing at the EndStr
--testNewConn cp@((w, b, agg):cs) (Node (0, _)) = (EndStr, 0, agg):cp   -- fill in the EndStr
-- This line is for approaching a new word... connected to aggWordFreqs
testNewConn cp@((w, 0, agg):cs) (Node wi) = (Node wi, (fst wi) - 1, aggWordFreqs agg wi):cp
-- This line is for carrying forward a long word
testNewConn cp@((w, b, agg):cs) _ = (w,b-1,agg):cp

-- iterate over testNewConn for all WordInfo's in a Position, given the CharPath leading up to it

findMaxPath :: [CharPath] -> CharPath  -- implemented vertically.  recursive max function
findMaxPath [x] = x
findMaxPath (a@(x:xs):b@(y:ys):xxs) =
  let third (_,_,z) = z
  in if (third x) > (third y) then findMaxPath (a:xxs) else findMaxPath (b:xxs)

findOpt :: CharPath -> Position -> CharPath -- given a fixed CharPath and Position, find the max based on testNewConn logic
findOpt cp ps =
  let pathChoices = map (\x -> testNewConn cp x) ps
  in findMaxPath pathChoices

firstStep :: Position -> [CharPath]
firstStep p = map (\x -> [(x, (getVal x) - 1, getFreq x)]) p

charStep :: [CharPath] -> WordGraph -> [CharPath]  -- get the heads of the charPaths, map these into
charStep [] (p:ps) = charStep (firstStep p) ps
charStep c ((p@[_, _, EndStr,_]):ps) = map (\x -> findOpt x p) c
charStep c (p:ps) = charStep (map (\x -> findOpt x p) c) ps

optimalPath :: WordGraph -> CharPath
optimalPath g = findMaxPath $ charStep [] g

encodeWordGraph :: [[Int]] -> WordGraph  -- for reading a 3xn trellis of integers
encodeWordGraph [(x:xs),(y:ys),(z:zs)] = [Node (4 :: Int, x), Node (3 :: Int, y), Node (2 :: Int,z)] : encodeWordGraph [xs, ys, zs]
encodeWordGraph [[],(y:ys),(z:zs)] = [EndStr, Node (3 :: Int,y), Node (2 :: Int,z)] : encodeWordGraph [[], ys, zs]
encodeWordGraph [[], [], (z:zs)] = [[EndStr, EndStr, Node (2 :: Int,z)]]

decodeWordPath :: CharPath -> WordPath
decodeWordPath [] = []
decodeWordPath ((a,b,c):cp) = if getVal a - 1 == b then decodeWordPath cp ++ [a] else decodeWordPath cp

addBottomNodes :: WordGraph -> WordGraph
addBottomNodes g = let
                   bottomNode ni = Node (1 :: Int, getFreq ni)
                   addBottomLayer ((x@[_, _, c]):[]) = [ x ++ [bottomNode c] ]
                   addBottomLayer ((x@[_, EndStr, c]):(y@[_, _, d]):xs) = [EndStr, EndStr, EndStr, bottomNode c] :
                                                                    if getFreq c > getFreq d
                                                                    then (x ++ [bottomNode c]) : (addBottomLayer (y:xs))
                                                                    else (x ++ [bottomNode c]) : (addBottomLayer (y:xs))
                   addBottomLayer ((x@[_, _, c]):(y@[_, _, d]):xs) = if getFreq c > getFreq d
                                                                    then (x ++ [bottomNode c]) : (addBottomLayer (y:xs))
                                                                    else (x ++ [bottomNode c]) : (addBottomLayer (y:xs))
                   in reverse $ addBottomLayer $ reverse $ g


--TODO:
-- prettify : print segmented string
-- toWordGraph :: String -> WordGraph

--exCase = zipPaths [262, 455] [1683, 578, 463] [7890, 3108, 591, 6362]
--decodeWordGraph function for taking a word parse --> WordGraph
exCase1 = map (map (\x -> x :: Int)) [[262, 455], [1683, 578, 443], [7890, 3108, 591, 6362]]
exCase2 = map (map (\x -> x :: Int)) [[20,20,1,1,1], [32,20,20,1,1,6], [36,117,20,10624,3,23,16645]]
exCase3 = map (map (\x -> x :: Int)) [[248,244,1818,1679,145,461,15],
                                      [248,249,11517,1818,1847,500,461,684],
                                      [8143,249,19755,11520,1988,116841,500,22650,684]]
exCase4 = map (map (\x -> x :: Int)) [[7,7,19,15,15,14,17],
                                      [7,7,19,19,15,15,20,17],
                                      [7,7,21,19,105,15,58,20,5867]]
exCase5 = map (map (\x -> x :: Int)) [[323,305,3980,19575,467,433,105,425,152],
                                      [323,357,4287,19602,81339,467,561,1896,611,10032],
                                      [18530,357,9294,20175,81452,81438,792,8401,2707,27958,185224]]

optCase1 = decodeWordPath $ optimalPath $ addBottomNodes $ encodeWordGraph exCase1
optCase2 = decodeWordPath $ optimalPath $ addBottomNodes $ encodeWordGraph exCase2
optCase3 = decodeWordPath $ optimalPath $ addBottomNodes $ encodeWordGraph exCase3
optCase4 = decodeWordPath $ optimalPath $ addBottomNodes $ encodeWordGraph exCase4
optCase5 = decodeWordPath $ optimalPath $ addBottomNodes $ encodeWordGraph exCase5
