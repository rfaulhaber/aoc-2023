module Main where

import X3
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Test cases" [testFindPosition, testAdjacent, testPart1]


testFindPosition = testGroup "Test Find Position" [
          testCase "Only numbers" $
          findPositions "467..114.." @?= [((0, 2), "467"), ((5, 7), "114")],
          testCase "Symbols" $
          findPositions "617*......" @?= [((0, 2), "617"), ((3, 3), "*")]
        ]

testAdjacent = testGroup "Test Adjacency Calculations" [
  testCase "Simple" $
  isAdjacent (0, 2) 3 @?= True
  , testCase "Exclusive" $
  isAdjacent (6, 8) 3 @?= False

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
