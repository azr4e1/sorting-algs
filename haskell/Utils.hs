-- module exporting the test function, which accept the sorting algorithm
-- to test and tests it against the list contained in 'input' at the root
-- of the project.
module Utils
  (test)
where

import qualified Data.Time as DT

-- read content of a single column dataset
-- and turn it into a list of numbers
readNewlineList :: (Ord n, Num n, Read n) => String -> [n]
readNewlineList "" = []
readNewlineList content = map read $ lines content

-- test the sorting function
test :: (Ord n, Num n, Read n) => ([n] -> [n]) -> IO()
test sorting = do
  testContent <- readFile "../input"
  validationContent <- readFile "../validation"
  let test = readNewlineList testContent
      validation = readNewlineList validationContent
  -- start timer
  startTime <- DT.getCurrentTime

  -- execute
  let output = sorting test

  -- stop timer
  endTime <- DT.getCurrentTime

  -- get time lapse
  let timeLapse = DT.diffUTCTime endTime startTime

  -- result
  if output == validation
    then print $ "Success! It took " <> show timeLapse
    else print "Failed!"
