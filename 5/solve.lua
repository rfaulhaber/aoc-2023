local io = require("io")
local string = require("string")
local range = require("range")

local unpack = table.unpack or unpack

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
		table.insert(mappings.seeds, tonumber(s))
	end

	local lastFrom, lastTo

	for line in fileLines do
		if string.match(line, "(%w+)%-to%-(%w+) map:") then
			local from, to = string.match(line, "(%w+)%-to%-(%w+) map:")
			mappings[from] = { [to] = {} }
			table.insert(mappings.path, { from = from, to = to })
			lastFrom = from
			lastTo = to
		elseif string.match(line, "(%d+) (%d+) (%d+)") then
			local destination, source, length = string.match(line, "(%d+) (%d+) (%d+)")
			local r = range:new(tonumber(destination), tonumber(source), tonumber(length))
			table.insert(mappings[lastFrom][lastTo], r)
		end
	end

	return mappings
end

function Solve.part1(filename)
	local mappings = parseInput(filename)

	local locations = {}

	for i, seed in ipairs(mappings.seeds) do
		local value = seed

		for i = 1, #mappings.path do
			local from = mappings.path[i].from
			local to = mappings.path[i].to

			local ranges = mappings[from][to]

			for _, r in ipairs(ranges) do
				if r:between(value) then
					value = r:nextValue(value)
					break
				end
			end
		end

		table.insert(locations, value)
	end

	return math.min(unpack(locations))
end

function Solve.part2(filename)
	print("filename for part 2: " .. filename)
end

return Solve
