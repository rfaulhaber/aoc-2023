local io = require("io")
local string = require("string")

local Solve = {}

function parseInput(filename)
	assert(io.open(filename, "r"))

	local fileLines = io.lines(filename)

	local firstLine = fileLines()

	local mappings = {
		seeds = {},
		path = {},
	}

	for s in string.gmatch(firstLine, "%d+") do
		table.insert(mappings.seeds, s)
	end

	local lastFrom, lastTo

	for line in fileLines do
		if string.match(line, "(%w+)%-to%-(%w+) map:") then
			local from, to = string.match(line, "(%w+)%-to%-(%w+) map:")
			mappings[from] = { [to] = {} }
			table.insert(mappings.path, { from, to })
			lastFrom = from
			lastTo = to
		elseif string.match(line, "(%d+) (%d+) (%d+)") then
			local destination, source, length = string.match(line, "(%d+) (%d+) (%d+)")
			table.insert(mappings[lastFrom][lastTo], { destination, source, length })
		end
	end

	return mappings
end

function traversePath(seed, mappings) end

function Solve.getNextValue(value, source, destination, length)
	if value >= destination and value <= destination + length then
		return (value - source) + destination
	end

	return value
end

function Solve.part1(filename)
	local input = parseInput(filename)

	for i = 1, #input.path do
		print(input.path[i][1] .. " to " .. input.path[i][2])
	end
end

function Solve.part2(filename)
	print("filename for part 2: " .. filename)
end

return Solve
