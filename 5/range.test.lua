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

function testLeftOverlap()
	local testCases = {
		{
			input = {
				left = { start = 1, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = true,
		},
		{
			input = {
				left = { start = 20, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = false,
		},
		{
			input = {
				left = { start = 5, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = false,
		},
	}

	for _, test in pairs(testCases) do
		local input = test.input
		local expected = test.expected

		luaunit.assertEquals(range.isLeftOverlap(input.left, input.right), expected)
	end
end

function testRightOverlap()
	local testCases = {
		{
			input = {
				left = { start = 1, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = false,
		},
		{
			input = {
				left = { start = 20, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = false,
		},
		{
			input = {
				left = { start = 5, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = true,
		},
	}

	for _, test in pairs(testCases) do
		local input = test.input
		local expected = test.expected

		luaunit.assertEquals(
			range.isRightOverlap(input.left, input.right),
			expected,
			string.format(
				"expected { %s, %s } to right overlap with { %s, %s }",
				input.left.start,
				input.left.length,
				input.right.start,
				input.right.length
			)
		)
	end
end

function testInnerOverlap()
	local testCases = {
		{
			input = {
				left = { start = 1, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = false,
		},
		{
			input = {
				left = { start = 20, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = false,
		},
		{
			input = {
				left = { start = 3, length = 5 },
				right = { start = 20, length = 5 },
			},
			expected = false,
		},
		{
			input = {
				left = { start = 5, length = 5 },
				right = { start = 3, length = 5 },
			},
			expected = false,
		},
		{
			input = {
				left = { start = 5, length = 5 },
				right = { start = 3, length = 10 },
			},
			expected = true,
		},
		{
			input = {
				left = { start = 3, length = 10 },
				right = { start = 5, length = 5 },
			},
			expected = false,
		},
	}

	for _, test in pairs(testCases) do
		local input = test.input
		local expected = test.expected

		luaunit.assertEquals(
			range.isInnerOverlap(input.left, input.right),
			expected,
			string.format(
				"expected { %s, %s } to inner overlap with { %s, %s }",
				input.left.start,
				input.left.length,
				input.right.start,
				input.right.length
			)
		)
	end
end

os.exit(luaunit.LuaUnit.run())
