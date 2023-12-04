#!/usr/bin/env python3

import re

def read_lines_from_file(path):
    with open(path) as file:
        return [line.rstrip() for line in file]

def parse_game(line):
    return [(int(count), color) for (count, color) in re.findall(r'(\d+)\s(\w+)', 'line')]

def find_max_color(pairs, color):
    return max(filter(lambda p: p[1] == color, pairs))



def part1(lines):
    red_count = 12
    green_count = 13
    blue_count = 14

    games = map(parse_game, lines)
