#!/usr/bin/env python3

import sys

def main():
    if len(sys.argv) < 3:
        print("not enough arguments!")
        exit(1)

    part = sys.argv[1]
    filename = sys.argv[2]

    match part:
        case "1":
            print("part 1")
        case "2":
            print("part 2")
        case _:
            print("I don't know what part this is!")


if __name__ == "__main__":
    main()
