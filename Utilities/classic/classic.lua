--
-- classic
--
-- Copyright (c) 2014, rxi
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
-- 

local Object = {
	_VERSION     = 'classic',
	_DESCRIPTION = 'Tiny self module for Lua',
	_URL         = 'https://github.com/rxi/classic',
	_LICENSE     = [[
 		Copyright (c) 2014, rxi
		Permission is hereby granted, free of charge, to any person obtaining a copy of
		this software and associated documentation files (the "Software"), to deal in
		the Software without restriction, including without limitation the rights to
		use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
		of the Software, and to permit persons to whom the Software is furnished to do
		so, subject to the following conditions:
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
	]]
}
Object.__index = Object

function Object.extend( self, name, meta, prefix ) -- Makes a new class that inherits values from the old.
	local new = {}
	meta = meta or true
	
	if meta then
		for index, value in pairs( self ) do
			if index:find( '__' ) == 1 then -- Meta-values typically start with '__'.
				new[index] = value 
			end
		end
	end
	new.__type = name
	new.__prefix = prefix or 'Class'	
	new.__index = new
	
	new.super = self -- Allows for easy-access to parents.
	
	return setmetatable( new, self )
end

function Object.implement( self, ... ) -- Adds all the keys from tab to class.
	local callbacks = {}
	for _, implementation in pairs( { ... } )  do
		for index, value in pairs( implementation ) do
			if index:find( '__callback' ) == 1 then
				table.insert( callbacks, value )
			end
			if self[index] == nil and type( value ) == 'function' then
				self[index] = value
			end
		end
	end
	for index = 1, #callbacks do
		callbacks[index]( self )
	end
end

function Object.is( self, tab ) -- Checks if an object inherits from another type of object.
	local mt = getmetatable( self )
	while mt do
		if mt == tab then return true end
		mt = getmetatable( mt ) -- Loop through all meta-tables until one matches.
	end
	return false 
end

function Object.type( self ) -- Use this to easily get the type of a class.
	return self.__type
end

function Object.new( self, ... )
end

function Object.destroy( self, ... )
end

function Object.instantiate( self ) -- Clone the current class.
	local new = self.super:extend()
	for index, value in pairs( self ) do
		if ( not new[index] ) or ( new[index] ~= self[index] ) then 
			new[index] = self[index]
		end
	end
	return new
end

function Object.__tostring( self )
	return string.format( '<%s: %s>', self.__prefix, self.__type )
end

function Object.__call( self, ... )
	local object = setmetatable( {}, self )
	object:new( ... )
	object.super = self
	return object
end

return Object