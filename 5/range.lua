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

function Range:rangeOverlap(start, length)
	local rangeEnd = start + length
	local sourceEnd = self.source + length

	-- overlap kinds
	-- mutually exclusive, e.g. (1, 1) and (3, 2)
	-- left, e.g. (1, 5) and (3, 5)
	-- right, e.g. (3, 5) and (5, 5)
	-- inner, e.g. (3, 5) and (2, 1)
	-- outer, e.g. (3, 5) and (1, 10)

	-- left
end

function Range.isLeftOverlap(left, right)
	local leftEnd = left.start + left.length

	return left.start < right.start and leftEnd > right.start
end

function Range.isRightOverlap(left, right)
	local rightEnd = right.start + right.length

	return left.start < rightEnd and left.start > right.start
end

function Range.isInnerOverlap(left, right)
	local leftEnd = left.start + left.length
	local rightEnd = right.start + right.length

	return left.start > right.start and leftEnd < rightEnd
end

-- function Range:nextRange(start, length)
-- 	local rangeEnd = start + length
-- 	local sourceEnd = self.source + length

-- 	if start < self.source and self:between(rangeEnd) then
-- 	elseif start > self.source and self:between(rangeEnd) then
-- 	elseif start < self.source and rangeEnd > sourceEnd
-- 	end

-- end

function Range:offset()
	return self.destination - self.source
end

return Range
