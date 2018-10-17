main = interact shortLinesOnly

shortLinesOnly :: String -> String
shortLinesOnly input =
   let allLines = lines input
       shortLines = filter (\line -> length line < 20) allLines
       result = unlines shortLines
   in  result

--alternatively, this program could be a one-liner....
-- main = interact $ unlines . filter ((<20) . length) . lines