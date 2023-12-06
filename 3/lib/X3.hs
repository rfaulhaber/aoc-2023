-- |

module X3 where

import Data.Char
import Data.List
import Debug.Trace

data Part = Part1 | Part2 deriving Eq

isNewLine :: Char -> Bool
isNewLine c = c == '\n'

-- thank you stackoverflow
trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isNewLine

-- TODO find position of every number
-- TODO find position of every symbol
-- TODO filter every number what is not adjacent to a symbol

isPeriod :: Char -> Bool
isPeriod c = c == '.'

-- stupid name, but I don't want to collide with Data.Char.isSymbol
isSpecialSymbol :: Char -> Bool
isSpecialSymbol c = not (isNumber c || isPeriod c)

findPositions :: String -> [((Int, Int), String)]
findPositions s = advance 0 s
  where
    advance :: Int -> String -> [((Int, Int), String)]
    advance index (x:xs) | isNumber x =
                           let rest = takeWhile isNumber xs
                               end = index + length rest
                           in
                             ((index, end), x : rest) : advance (end + 1) (drop end xs)
    advance index (x:xs) | isSpecialSymbol x = ((index, index), [x]) : advance (index + 1) xs
    advance index ('.':xs) = advance (index + 1) xs
    advance index _ = []

isAdjacent :: (Int, Int) -> Int -> Bool
isAdjacent (x1, x2) y = y >= x1 - 1 && y <= x2 + 1


solve :: Part -> String -> Int
solve part str = if part == Part1 then solvePart1 str else solvePart2 str

solvePart1 :: String -> Int
solvePart1 content = let l = lines content
                         positions = concatMap findPositions l
                         (symbolPositions, numberPositions) = partition (\(_, x) -> isSpecialSymbol (head x)) positions
                         symbolPositionDigits = map (\((x, _), _) -> x) symbolPositions
                         adjacentNumbers = filter (\(pos, _) -> hasAdjacent pos symbolPositionDigits) numberPositions
                in
                       sum (map (\(_, n) -> ( read n :: Int )) (trace ("adjacent: " ++ show adjacentNumbers) adjacentNumbers))
        where
          hasAdjacent :: (Int, Int) -> [Int] -> Bool
          hasAdjacent pos l | trace ("hasAdjacent" ++ show pos ++ " " ++ show l) False = undefined
          hasAdjacent pos (x:xs) = isAdjacent pos x || hasAdjacent pos xs
          hasAdjacent pos _ = False

solvePart2 :: String -> Int
solvePart2 = undefined
