local luaunit = require("luaunit")
local solve = require("solve")

function testRange()
	local expected = { 1, 2, 3, 4, 5 }

	local result = {}

	for n in solve.range(1, 5) do
		table.insert(result, n)
	end

	luaunit.assertEquals(result, expected)
end

function testNextValue()
	local tests = {
		[79] = 81,
		[14] = 14,
		[55] = 57,
		[13] = 13,
	}

	for k, v in pairs(tests) do
		luaunit.assertEquals(solve.getNextValue(k, 50, 52, 48), v)
	end
end

os.exit(luaunit.LuaUnit.run())
