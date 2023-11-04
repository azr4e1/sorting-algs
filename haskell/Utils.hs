-- module exporting the test function, which accept the sorting algorithm
-- to test and tests it against the list contained in 'input' at the root
-- of the project.
module Utils
  (test)
where

import qualified Data.Time as DT
import qualified Data.List as DL
import System.Directory (getDirectoryContents)
import Control.Monad (zipWithM)

testDir :: String
testDir = "/home/ld/Desktop/Projects/sorting-algs/tests"

-- read content of a single column dataset
-- and turn it into a list of numbers
readNewlineList :: (Ord n, Num n, Read n) => String -> [n]
readNewlineList "" = []
readNewlineList content = map read $ lines content

testEndFile :: FilePath -> String -> Bool
testEndFile "" test = False
testEndFile str test =
  let lengthTest = length test
      lengthStr = length str
      toDrop = lengthStr - lengthTest
  in drop toDrop str == test

getInputFiles :: FilePath -> IO [FilePath]
getInputFiles dir = do
  files <- getDirectoryContents dir
  let inputs = [dir <> "/" <> file | file <- files, testEndFile file "_input"]
  pure $ DL.sort inputs

getValidationFiles :: FilePath -> IO [FilePath]
getValidationFiles dir = do
  files <- getDirectoryContents dir
  let validation = [dir <> "/" <> file | file <- files, testEndFile file "_validation"]
  pure $ DL.sort validation

-- test the sorting function
singleTest :: (Ord n, Num n, Read n) => ([n] -> [n]) -> FilePath -> FilePath -> IO String
singleTest sorting inputFile validationFile = do
  testContent <- readFile inputFile
  validationContent <- readFile validationFile
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
    then pure $ "Success! It took " <>
                show timeLapse <>
                " to sort " <>
                show (length test) <>
                " elements."
    else pure "Failed!"

test :: (Ord n, Num n, Read n) => ([n] -> [n]) -> IO ()
test sorting = do
  inputs <- getInputFiles testDir
  validations <- getValidationFiles testDir
  result <- zipWithM (singleTest sorting) inputs validations
  putStr $ unlines result