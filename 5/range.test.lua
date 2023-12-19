local luaunit = require("luaunit")
local range = require("range")

function testBetween()
	local testRange = range:new(52, 50, 48)

	luaunit.assertTrue(testRange:between(52))
	luaunit.assertFalse(testRange:between(98))
	luaunit.assertTrue(testRange:between(50))
end

function testNextValue()
	local testRange = range:new(52, 50, 48)

	luaunit.assertEquals(testRange:nextValue(79), 81)
	luaunit.assertEquals(testRange:nextValue(14), 14)
	luaunit.assertEquals(testRange:nextValue(55), 57)
	luaunit.assertEquals(testRange:nextValue(13), 13)
end

os.exit(luaunit.LuaUnit.run())
