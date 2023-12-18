local luaunit = require("luaunit")
local range = require("range")

function testBetween()
	local testRange = range:new(50, 48)

	luaunit.assertTrue(testRange:between(52))
	luaunit.assertFalse(testRange:between(98))
	luaunit.assertTrue(testRange:between(50))
end

os.exit(luaunit.LuaUnit.run())
