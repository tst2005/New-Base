local Class = {}
Class.__index = Class

function Class.Extend( Self )
	local New = {}
	
	New.__index = New
	New.Super = Self
	setmetatable( New, Self )
	
	return New
end

return Class