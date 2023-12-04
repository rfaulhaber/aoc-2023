import unittest
import solution

lines = [ '1abc2', 'pqr3stu8vwx', 'a1b2c3d4e5f', 'treb7uchet' ]
complex_lines = ['two1nine', 'eightwothree', 'abcone2threexyz', 'xtwone3four', '4nineeightseven2', 'zoneight234', '7pqrstsixteen' ]

class Tests(unittest.TestCase):
    def test_find_first_and_last_digit(self):
        inputs = lines
        expecteds = [12, 38, 15, 77]

        for [input, expected] in zip(inputs, expecteds):
            output = solution.find_digits_for_line(input)
            self.assertEqual(output, expected)

    def test_part1(self):
        output = solution.part1(lines)
        self.assertEqual(output, 142)

    def test_find_digits_or_words(self):
        inputs = complex_lines
        expecteds = [29, 83, 13, 24, 42, 14, 76]

        for [input, expected] in zip(inputs, expecteds):
            output = solution.find_digits_or_words_from_line(input)
            self.assertEqual(output, expected, f"expected: {expected} but got {output}")

    def test_matches(self):
        input = "heightwosixthzdf7gdtllhsnfive1onemfcqkqfqkj1"
        expected = 81

        output = solution.find_digits_or_words_from_line(input)

        self.assertEqual(output, expected)

    def test_part2_with_file(self):
        with open("./sample2.txt") as file:
            lines = [line.rstrip() for line in file]
            output = solution.part2(lines)
            self.assertEqual(output, 281)


if __name__ == "main":
    unittest.main()
