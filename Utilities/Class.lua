local Class = {}
Class.__index = Class

function Class.extend( self )	
	local new = { 
		super = self, 
		__class = true, 
		__type = 'class'
	}
	for i, v in pairs( self ) do
		if i:find( '__' ) == 1 then -- Make sure to get meta-functions, such as __call
			new[i] = v
		end
	end
	
	new.__index = new

	return setmetatable( new, self )
end

function Class.mixin( self, tab )
	for i, v in pairs( tab ) do
		if self[i] == nil and type( v ) == 'function' then
			self[i] = v
		end
	end
	return self
end

function Class.type( self )
	return self.__type
end

function Class.typeOf( ... )
	local strings = { ... }
	local _type = self:type()
	for i = 1, #strings do 
		if __type == strings[i] then return true end
	end
	return false
end

function Class.setType( self, type )
	self.__type = type
end

function Class.__tostring( self )
	return '<' .. self.__type .. '>'
end

function Class.new()
end

function Class.__call( self, ... )
	return self.new( ... )
end

return Class