local Class = require 'Utilities.Class'
local State = Class:Extend()
State.Stack = {}

function State.Set( Stack, To, Index )
	if Index then table.remove( State.Stack, Index ) end 
	-- Should only be removing from end of stack, so don't have to worry about performance impact because of table.remove

	local Length = #Stack
	
	local Enter = To.Enter or function() end
	local Exit = Length > 0 and State.Stack[Length].Exit or function() end
	
	Exit()
	Enter()
	
	State.Stack[Length + 1] = To
	
	return To
end

function State.GetCurrentState( Stack )
	return Stack[#Stack]
end

function State.Pop( Stack )
	local Index = #Stack
	
	assert( Index > 1, 'State Error: Attempt to pop with no values remaining!' )
	local To State.Set( Stack[Index - 1], Index )
	table.remove( Stack, Index )
	
	return To
end

return State