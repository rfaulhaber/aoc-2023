-- range isn't the best name for this data type
-- it's really a kind of mapping

local Range = {}

function Range:new(start, length)
	local obj = {
		start = start,
		finish = start + length,
		length = length,
	}

	self.__index = self

	return setmetatable(obj, self)
end

function Range:between(value)
	return value >= self.start and value < self.finish
end

return Range
