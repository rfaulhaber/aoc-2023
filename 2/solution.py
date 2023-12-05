#!/usr/bin/env python3

import re

def read_lines_from_file(path):
    with open(path) as file:
        return [line.rstrip() for line in file]

def parse_game(line) -> [(int, str)]:
    return [(int(count), color) for (count, color) in re.findall(r'(\d+)\s(\w+)', line)]

def valid_game(game: [(int, str)]) -> bool:
    red_max = max([c for (c, color) in game if color == "red"])
    blue_max = max([c for (c, color) in game if color == "blue"])
    green_max = max([c for (c, color) in game if color == "green"])

    return red_max <= 12 and green_max <= 13 and blue_max <= 14

def min_colors(game: [(int, str)]) -> (int, int, int):
    red_max = max([c for (c, color) in game if color == "red"])
    blue_max = max([c for (c, color) in game if color == "blue"])
    green_max = max([c for (c, color) in game if color == "green"])

    return (red_max, green_max, blue_max)

def part1(lines):
    games = [parse_game(line) for line in lines]

    valid_games = [game for game in enumerate(games) if valid_game(game[1])]

    return sum([game[0]+1 for game in valid_games])

def part2(lines):
    games = [parse_game(line) for line in lines]

    min_colors_for_game = [min_colors(game) for game in games]

    powers = [r*g*b for (r, g, b) in min_colors_for_game]

    return sum(powers)
