import qualified Utils as U

-- implement quicksort
quickSort :: Ord n => [n] -> [n]
quickSort [] = []
quickSort (x:xs) =
  let smallSorted = quickSort [a | a <- xs, a <= x]
      bigSorted = quickSort [a | a <- xs, a > x]
  in smallSorted <> [x] <> bigSorted

main :: IO ()
main = do
  U.test quickSort
