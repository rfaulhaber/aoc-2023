type part = Part1 | Part2

let solve_part_1 input = input
let solve_part_2 input = input

let solve_part part input =
    match part with
        Part1 -> solve_part_1 input
        Part2 -> solve_part_2 input
