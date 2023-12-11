let part = ref 0

let input = ref ""

let unnamed_args = ref []

let rest arg = unnamed_args := arg :: !unnamed_args

let speclist =
  [("--part", Arg.Set_int part, "Part to solve");
   ("--input", Arg.Set_string input, "Input file text")]

let exit_with_message message =
    print_endline message;
    exit 0

let () =
    Arg.parse speclist rest "day4 --part <1|2> --input <filename>" ;;

    if !part == 0
        then exit_with_message "no part specified"
    else if !input == ""
        then exit_with_message "no input file specified"
    else
        print_endline (Day4.solve_part (if !part == 1 then Part1 else Part2) !input)
