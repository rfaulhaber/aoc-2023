module Main where

import X3
import System.Environment
import System.Exit
import Text.Printf

main :: IO ()
main = do
  args <- getArgs
  if length args < 2
    then do
      print "Not enough arguments!"
      exitFailure
  else do
        let part = head args
            file = args !! 1
        contents <- readFile file
        print (solve (if part == "1" then Part1 else Part2) contents)
