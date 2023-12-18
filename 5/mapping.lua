Mapping = {}

function Mapping:new(from, to, ranges)
	obj = {
		from = from,
		to = to,
		ranges = ranges,
	}

	self.__index = self

	return setmetatable(obj, self)
end

return Mapping
