import re

words_to_numbers = {
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9"
}

def read_lines_from_file(path):
    with open(path) as file: 
        return [line.rstrip() for line in file]

def find_digits_for_line(line):
    matches = re.findall(r'(\d{1})', line)
    return int(matches[0] + matches[-1])

def normalize_digit(digit):
    if digit.isnumeric():
        return digit

    return words_to_numbers[digit]


def find_digits_or_words_from_line(line):
    matches = re.findall(r'(?=(\d{1}|one|two|three|four|five|six|seven|eight|nine))', line)

    first = normalize_digit(matches[0])
    last = normalize_digit(matches[-1])

    ret = int(first + last)

    return ret

def part1(lines):
    return sum(map(find_digits_for_line, lines))

def part2(lines):
    return sum(map(find_digits_or_words_from_line, lines))
