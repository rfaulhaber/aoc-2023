-- range isn't the best name for this data type
-- it's really a kind of mapping

local Range = {}

function Range:new(destination, source, length)
	local obj = {
		source = source,
		destination = destination,
		length = length,
	}

	self.__index = self

	return setmetatable(obj, self)
end

function Range:between(value)
	local finish = self.source + self.length
	return value >= self.source and value < finish
end

function Range:nextValue(value)
	if self:between(value) then
		return (value - self.source) + self.destination
	else
		return value
	end
end

return Range
