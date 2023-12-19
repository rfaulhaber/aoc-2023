local solve = require("solve")
local os = require("os")
local io = require("io")

local unpack = table.unpack or unpack

local part, filename = unpack(arg)

if part == nil then
	print("Part is required")
	os.exit(1)
elseif filename == nil then
	print("Filename is required")
	os.exit(1)
end

local solver

if part == "1" then
	solver = solve.part1
elseif part == "2" then
	solver = solve.part2
else
	print("I don't know what part that is!")
	os.exit(1)
end

local result = solver(filename)

print(result)
