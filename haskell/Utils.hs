-- module exporting the test function, which accept the sorting algorithm
-- to test and tests it against the list contained in 'input' at the root
-- of the project.
module Utils
  (test)
where

-- read content of a single column dataset
-- and turn it into a list of numbers
readNewlineList :: (Num n, Read n) => String -> [n]
readNewlineList "" = []
readNewlineList content = map read $ lines content

-- test the sorting function
test :: (Eq n, Num n, Read n) => ([n] -> [n]) -> IO()
test sorting = do
  testContent <- readFile "../input"
  validationContent <- readFile "../validation"
  let test = readNewlineList testContent
      validation = readNewlineList validationContent
      output = sorting test
  if output == validation then print "Success!" else print "Failed!"
