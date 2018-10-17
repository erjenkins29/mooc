import Control.Monad

--main = do
--    c <- getChar
--    when (c /= ' ') $ do
--          putChar c
--          main

-- sequence: takes a list of I/O actions and returns an I/O action that will perform those actions one at a time
--main = do sequence (map print [1,2,3,4,5])

--main = do mapM_ print [1,2,3,4,5]

-- forever : put before a do block, it will repeat the I/O action performed in do block
-- forM: takes a list of values + function to map over that list, which then can be sequenced
main = do   
    colors <- forM [1,2,3,4] (\a -> do  
        putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"  
        color <- getLine  
        return color)  
    putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "  
    mapM putStrLn colors  

