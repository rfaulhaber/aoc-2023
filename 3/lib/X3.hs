-- |

module X3 where

import Data.Char
import Data.List
import Debug.Trace

data Part = Part1 | Part2 deriving Eq

type Position = (Int, Int)

-- line, start, end
type PositionWithLine = (Int, Int, Int)

isNewLine :: Char -> Bool
isNewLine c = c == '\n'

isStar :: Char -> Bool
isStar c = c == '*'

-- thank you stackoverflow
trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isNewLine

-- thank you stackoverflow
-- despite the post saying "enumerate isn't usually spelled out", I'm doing it
enumerate :: (Num a, Enum a) => [b] -> [(a, b)]
enumerate = zip [0..]

-- TODO find position of every number
-- TODO find position of every symbol
-- TODO filter every number what is not adjacent to a symbol

isPeriod :: Char -> Bool
isPeriod c = c == '.'

-- stupid name, but I don't want to collide with Data.Char.isSymbol
isSpecialSymbol :: Char -> Bool
isSpecialSymbol c = not (isNumber c || isPeriod c)

findPositions :: (Char -> Bool) -> String -> [(Position, String)]
findPositions symbolFn = advance 0
  where
    -- this is basically a naive functional parser
    advance :: Int -> String -> [(Position, String)]
    -- advance index str | trace ("advance: " ++ show index ++ " " ++ show str) False = undefined
    advance index (x:xs) | isNumber x =
                           let rest = takeWhile isNumber xs
                               end = index + length rest
                               number = (x : rest)
                               dropLen = length rest
                           in
                             ((index, end), number) : advance (index + length number) (drop dropLen xs)
    advance index (x:xs) | symbolFn x = ((index, index), [x]) : advance (index + 1) xs
    advance index (x:xs) | not (symbolFn x) = advance (index + 1) xs
    advance index _ = []

findPositionsSpecialSymbols :: String -> [(Position, String)]
findPositionsSpecialSymbols = findPositions isSpecialSymbol

isAdjacent :: PositionWithLine -> (Int, Int) -> Bool
isAdjacent (xline, x1, x2) (yline, y) = abs (xline - yline) <= 1 && y >= x1 - 1 && y <= x2 + 1

hasAdjacent :: PositionWithLine -> [(Int, Int)] -> Bool
hasAdjacent pos (x:xs) = isAdjacent pos x || hasAdjacent pos xs
hasAdjacent pos _ = False

findAllAdjacent :: (Int, Int) -> [(PositionWithLine, String)] -> [String]
findAllAdjacent pos (x:xs) = if isAdjacent position pos then str : findAllAdjacent pos xs else findAllAdjacent pos xs
  where (position, str) = x
        (l, s, e) = position
findAllAdjacent pos [] = []

solve :: Part -> String -> Int
solve part str = if part == Part1 then solvePart1 str else solvePart2 str

numberedLines :: String -> [(Int, String)]
numberedLines = enumerate . lines

positionsForNumberedLines :: (Char -> Bool) -> [(Int, String)] -> [(PositionWithLine, String)]
positionsForNumberedLines symbolFn = concatMap (\(i, p) -> posWithLine i (findPositions symbolFn p))

posWithLine :: Int -> [(Position, String)] -> [(PositionWithLine, String)]
posWithLine lineNumber (x:xs) = ((lineNumber, start, end), s) : posWithLine lineNumber xs
  where
    (h, s) = x
    (start, end) = h
posWithLine lineNumber [] = []

solvePart1 :: String -> Int
solvePart1 content = let l = numberedLines content
                         positions = positionsForNumberedLines isSpecialSymbol l
                         (symbolPositions, numberPositions) = partition (\(_, x) -> isSpecialSymbol (head x)) positions
                         symbolPositionDigits = map (\((l, s, _), _) -> (l, s)) symbolPositions
                         adjacentNumbers = filter (\(pos, _) -> hasAdjacent pos symbolPositionDigits) numberPositions
                in
                       sum (map (\(_, n) -> read n :: Int)  adjacentNumbers)

solvePart2 :: String -> Int
solvePart2 content = let l = numberedLines content
                         positions = positionsForNumberedLines isStar l
                         (symbolPositions, numberPositions) = partition (\(_, x) -> isStar (head x)) positions
                         symbolPositionDigits = map (\((l, s, _), _) -> (l, s)) symbolPositions
                         symbolPositionsWithAdjacent = map (\p -> findAllAdjacent p numberPositions) symbolPositionDigits
                         exactlyTwo = filter ((==2) . length) symbolPositionsWithAdjacent
                         exactlyTwoAsInt = map (map (\n  -> read n :: Int)) exactlyTwo
                in
                       sum (map product exactlyTwoAsInt))
                where
                  findExactlyTwo :: [[(Int, Int)]] -> [[(Int, Int)]]
                  findExactlyTwo = filter ((== 2) . length)
