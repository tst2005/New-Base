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

-- Description: Makes a new class that inherits values from the old.
-- Arguments:
-- 		self: 		table				Any table that should have its values inherited.
-- 		name:		string				The name of the class. Mostly for debugging.
-- 		meta		boolean (true)		If the new table should inherit meta-methods.
-- 		prefix		string ('Class')	The prefix for the class.
-- Returns: 
-- 		new			table			The new class object.
function Object.extend( self, name, meta, prefix )
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

-- Description: Adds all the keys from tab to class.
-- Arguments: 
-- 		self: 		table			Any table that should have functions added.
--		...:		tables			All the tables to be implemented into the table.
function Object.implement( self, ... )
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

-- Description: Checks if an object inherits from another type of object.
-- Arguments: 
-- 		self: 		table		Any table.
-- 		tab:		table		Name of the table to check.
-- Returns: 
-- 		isType		boolean		Whether the tab is in the class.
function Object.is( self, tab )
	local mt = getmetatable( self )
	while mt do
		if mt == tab then return true end
		mt = getmetatable( mt ) -- Loop through all meta-tables until one matches.
	end
	return false 
end

-- Description: Use this to easily get the type of a class.
-- Arguments: 
-- 		self		table		Any table.
-- Returns: 
-- 		type		string		The type of class.
function Object.type( self )
	return self.__type
end

-- Description: Method to be overridden by each class manually. Called on object creation. 
function Object.new( self, ... )
end

-- Description: Method to be overridden by each class. Called on object destruction.
function Object.destroy( self, ... )
end

-- Description: Clone the current class.
-- Parameters: 
-- 		self: 		table 		Any table returned by the class method.
-- Returns: 
-- 		new			table		An exact copy of the previous table.
function Object.instantiate( self )
	local new = self.super:extend()
	for index, value in pairs( self ) do
		if ( not new[index] ) or ( new[index] ~= self[index] ) then 
			new[index] = self[index]
		end
	end
	return new
end

-- Description: The __tostring meta-method, called when you try do do print( Object ).
-- Arguments: 
-- 		self: 		table		Any table with the __type field.
function Object.__tostring( self )
	return string.format( '<%s: %s>', self.__prefix, self.__type )
end

-- Description: The __call meta-method, called when you do Object()
-- Arguments: 
-- 		self: 		table		Any table.
-- 		...: 		Anything	Any variables that are used in the Object:new() function.
-- Returns: 
-- 		object: 	table		A new creation of the object.
function Object.__call( self, ... )
	local object = setmetatable( {}, self )
	object:new( ... )
	return object
end

return Object