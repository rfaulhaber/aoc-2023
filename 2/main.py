#!/usr/bin/env python3

import sys
import solution

def main():
    if len(sys.argv) < 3:
        print("not enough arguments!")
        exit(1)

    part = sys.argv[1]
    filename = sys.argv[2]

    lines = solution.read_lines_from_file(filename)

    match part:
        case "1":
            print(solution.part1(lines))
        case "2":
            print(solution.part2(lines))
        case _:
            print("I don't know what part this is!")


if __name__ == "__main__":
    main()
