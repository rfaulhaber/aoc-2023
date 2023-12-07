module Main where

import X3
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Test cases" [
  testFindPosition
  -- testAdjacent,
  -- testPart1
  ]


testFindPosition = testGroup "Test Find Position" [
          testCase "Only numbers" $
          findPositions "467..114.." @?= [((0, 2), "467"), ((5, 7), "114")],
          testCase "Symbols" $
          findPositions "617*......" @?= [((0, 2), "617"), ((3, 3), "*")],
          testCase "Middle" $
          findPositions "...164...777..." @?= [((3, 5), "164"), ((9, 11), "777")]
        ]

testAdjacent = testGroup "Test Adjacency Calculations" [
  testCase "Simple" $
  isAdjacent (0, 0, 2) (1, 3) @?= True
  , testCase "Middle" $
  isAdjacent (2, 3, 5) (1, 4) @?= True
  , testCase "Exclusive" $
  isAdjacent (0, 1, 2) (2, 2) @?= False
                                                       ]

testPart1 = testGroup "Part 1" [
  testCase "Sample" $
  solvePart1 ("467..114..\n" ++
             "...*......\n" ++
             "..35..633.\n" ++
             "......#...\n" ++
             "617*......\n" ++
             ".....+.58.\n" ++
             "..592.....\n" ++
             "......755.\n" ++
             "...$.*....\n" ++
             ".664.598..") @?= 4361
   ]
