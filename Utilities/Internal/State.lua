local State = {}

-- Default class.setState function. 
local function _setstate( class, state, ... )
	local previous = class.__stateStack[#class.__stateStack]
	print( string.format( 'Switching to state %s, from state %s.', state, previous ) )
	class.__stateStack[#class.__stateStack + 1] = state
end

-- Default class.popState function.
local function _popstate( class )
	local state = class.__stateStack[#class.__stateStack]
	assert( state, 'State Error: Attempt to pop state of class with no remaining states.' )
	print( string.format( 'Popping state %s.', state ) )
	class.__stateStack[#class.__stateStack] = nil
end

-- Default class.getClass function.
local function _getclass( class, name )
	for index, value in pairs( class.__states ) do
		if index == name then return value end
	end
	return nil
end

-- Default class.removeState function.
local function _removestate( class, name )
	print( string.format( 'Removing state %s.', name ) )
	class.__states[name] = nil
	local pattern = string.format( '<State: %s>', name )
	for index, value in pairs( class.__stateStack ) do -- Pairs to safely iterate.
		local named = tostring( value )
		if named == pattern then table.remove( class.__stateStack, index ) end
	end
end

-- Description: Prepares the table for the "state infrastructure."
-- Arguments: 
-- 		class		table 		The class/table being given a state.
local function prepareTable( class )
	class.__stateStack = class.__stateStack or {}
	class.__states = class.__states or {}
	
	class.setState = class.setState or _setstate
	class.popState = class.popState or _popstate
	class.getState = class.getState or _getclass
	class.removeState = class.removeState or _removestate
end

-- Description: Creates the framework for the state being added.
-- Arguments: 
-- 		class		table 		The class/table being given a state.
-- 		name		string		The name of the state.
-- Returns: 
-- 		new			table		The method by which to edit the states.
local function newState( class, name )
	local new = class:extend( name, true, 'State' )
	prepareTable( class )
	return new
end

-- Description: Adds a new state to the class.
-- Arguments: 
-- 		class		table		The class/table to give a state.
-- 		name		string		The name of the state.
-- Returns: 
-- 		new			table		The method by which to edit the states.
function State.addState( class, name )
	local new = newState( class, name )
	class.__states[name] = new
	local mt = getmetatable( class )
	
	-- Assign the index meta-method like this so it won't overwrite the class in a local scope, then discard the changes down the road.
	class.__index = function( tab, index ) 
		-- First look through currently implemented class.
		if class.__stateStack and #class.__stateStack > 0 then
			for i, v in pairs( class.__stateStack[#class.__stateStack] ) do -- Look through the currently active state first.
				if index == i then return class.__stateStack[#class.__stateStack][i] end
			end
		end
		-- Then look through the class.
		for i, v in pairs( class ) do 
			if index == i then return class[i] end
		end
		for i, v in pairs( mt ) do
			if index == i then return mt[i] end
		end
		return nil
	end
	
	return new
end

-- Description: Adds all the keys from tab to class.
-- Arguments: 
-- 		self: 		table			Any table that should have functions added.
--		...:		tables			All the tables to be implemented into the table.
function Stack.implement( self, ... )
	for _, implementation in pairs( { ... } )  do
		for index, value in pairs( implementation ) do
			if self[index] == nil and type( value ) == 'function' then
				self[index] = value
			end
		end
	end
end

return State