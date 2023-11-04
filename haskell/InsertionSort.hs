import qualified Utils as U
import Data.List (foldl')

insertionSort :: (Ord n) => [n] -> [n]
insertionSort [] = []
insertionSort (x:xs) =
  foldl' insertion [x] xs
  where
    insertion [] y = [y]
    insertion ys y =
      let lastEl = last ys
      in
        if lastEl > y
          then insertion (init ys) y <> [lastEl]
          else ys <> [y]

main :: IO ()
main = do
  U.test insertionSort
