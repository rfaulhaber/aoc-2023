module X1 where

import           System.IO
import Data.Char

data Part = Part1 | Part2

getNumbersFromLine :: String -> [String]
getNumbersFromLine (x:xs) = if isNumber x then x ++ getNumbersFromLine xs else getNumbersFromLine xs

getFirstAndLastNumberFromLine :: String -> (Int, Int)
getFirstAndLastNumberFromLine l = let numbers = getNumbersFromLine l
  in
  (read (head numbers), read (last numbers))

addTuple :: (Int, Int) -> Int
addTuple (x, y) = x + y


getLinesFromFile :: String -> IO [String]
getLinesFromFile filename = do
    contents <- readFile filename
    return (lines contents)

solve :: Part -> [String] -> Int
solve Part1 lines = solvePart1 lines
solve Part2 lines = solvePart2 lines

solvePart1 :: [String] -> Int
solvePart1 = sum . map (addTuple . getFirstAndLastNumberFromLine)

solvePart2 :: [String] -> Int
solvePart2 = undefined
