import qualified Utils as U
import Data.List (foldl')

insertionSort :: (Ord n) => [n] -> [n]
insertionSort [] = []
insertionSort (x:xs) =
  foldl' insert [x] xs
  where
    insert [] y = [y]
    insert ys y =
      let lastEl = last ys
      in
        if lastEl > y
          then insert (init ys) y <> [lastEl]
          else ys <> [y]

-- from: https://stackoverflow.com/questions/28550361/insertion-sort-in-haskell
insertionSort' :: (Ord n) => [n] -> [n]
insertionSort' [] = []
insertionSort' [x] = [x]
insertionSort' (x:xs) = insert $ insertionSort' xs
  where insert [] = [x]
        insert (y:ys)
          | x <= y = x:y:ys
          | x > y = y:insert ys


main :: IO ()
main = do
  U.test insertionSort'
