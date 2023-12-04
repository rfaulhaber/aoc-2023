import sys
import solution

def main():
    if len(sys.argv) < 3:
        print("You forgot arguments!")
        exit(1)

    part = sys.argv[1]
    file = sys.argv[2]
    lines = solution.read_lines_from_file(file)

    if part == "1":
        s = solution.part1(lines)
        print(f"part 1: {s}")
    elif part == "2":
        s = solution.part2(lines)
        print(f"part 2: {s}")
    else:
        print(f"I don't know what {part} is!")

if __name__ == '__main__':
    main()
