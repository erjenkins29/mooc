import Data.List

--example possibilities
data Node = Node Road Road | EndNode Road
data Road = Road Int Node

--data types to be used
data Section = Section {getA :: Int, getB :: Int, getC :: Int } deriving (Show)
type RoadSystem = [Section]

--example data
heathrowToLondon :: RoadSystem
heathrowToLondon = [Section 50 10 30, Section 5 90 20, Section 40 2 25, Section 10 8 0]

data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]

lengthOfPath :: Path -> Int
lengthOfPath path = sum $ map snd path

roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (path1, path2) (Section a b c) =
  let price1 =  lengthOfPath path1
      price2 =  lengthOfPath path2
      longway1 = b + c + price2
      shortway1 = a + price1
      longway2 = a + c + price1
      shortway2 = b + price2
      opPath1 = if longway1 > shortway1
                  then (A, a):path1
                  else (C, c):(B, b):path2
      opPath2 = if longway2 > shortway2
                  then (B, b):path2
                  else (C, c):(A, a):path1
  in (opPath1, opPath2)

optimalPath :: RoadSystem -> Path
optimalPath roads =
  let (path1, path2) = foldl roadStep ([],[]) roads
      len1 = lengthOfPath path1
      len2 = lengthOfPath path2
  in if len1 <= len2 then reverse path1 else reverse path2
