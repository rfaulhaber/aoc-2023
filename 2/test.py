#!/usr/bin/env python3

import pytest
import solution

def test_parse_game():
    game = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"

    expected = [(1, "green"), (3, "red"), (6, "blue"), (3, "green"), (6, "red"), (3, "green"), (15, "blue"), (14, "red")]

    result = solution.parse_game(game)

    assert result == expected

def test_valid_game():
    game = [(1, "green"), (3, "red"), (6, "blue"), (3, "green"), (6, "red"), (3, "green"), (15, "blue"), (14, "red")]

    assert solution.valid_game(game) == False


def test_part_1():
    lines = solution.read_lines_from_file("./2/sample.txt")
    result = solution.part1(lines)

    expected = 8

    assert result == expected

def test_part_2():
    lines = solution.read_lines_from_file("./2/sample.txt")
    result = solution.part2(lines)

    expected = 2286

    assert result == expected
