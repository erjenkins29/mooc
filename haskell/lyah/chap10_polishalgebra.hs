import Data.List

solveRPN :: String -> Float
solveRPN = head . foldl foldingFunction [] . words
    where foldingFunction (x:y:ys) "*" = x*y:ys
          foldingFunction (x:y:ys) "+" = x+y:ys
          foldingFunction (x:y:ys) "-" = x-y:ys
          foldingFunction xs "sum" = [sum xs]
          foldingFunction (x:y:xs) "/" = x/y:xs
          foldingFunction (x:xs) "ln" = (log x):xs
          foldingFunction xs numberString = read numberString:xs