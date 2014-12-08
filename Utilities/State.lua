local Class = require 'Utilities.Class'
local State = Class:extend()
State.stack = {}

function State.set( to, index )	
	local length = #State.stack
	
	local enter = To.Enter or function() end
	local exit = length > 0 and State.stack[length].exit or function() end
	
	local information = exit()
	enter( information )
	
	State.stack[Length + 1] = to
	
	if index then table.remove( State.stack, index ) end 
	-- Should only be removing from end of stack, so don't have to worry about performance impact because of table.remove
	
	return to
end

function State.getCurrentState()
	return State.stack[#State.stack]
end

function State.pop( stack )
	local index = #State.stack
	
	assert( index > 1, 'State Error: Attempt to pop with no values remaining!' )
	local to = State.set( State.stack[index - 1], index )
	
	return to
end

return State