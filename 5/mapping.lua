Mapping = {}

function Mapping:new(ranges)
	obj = {
		ranges = ranges,
	}

	self.__index = self

	return setmetatable(obj, self)
end

function Mapping:next_value() end

return Mapping
