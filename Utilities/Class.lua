local Class = {}
Class.__index = Class

function Class.extend( self )
	local New = {}
	
	New.__index = New
	New.super = Self
	New.class = true
	New.type = 'class'
	setmetatable( New, self )
	
	return New
end

return Class