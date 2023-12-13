local luaunit = require("luaunit")
local solve = require("solve")

function test()
	luaunit.assertEquals(1, 1)
end

os.exit(luaunit.LuaUnit.run())
