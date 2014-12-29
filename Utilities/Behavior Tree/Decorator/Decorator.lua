local Behavior = require 'Utilities.Behavior Tree.Behavior'
local Decorator = Behavior:extend()

function Decorator.new( name, behavior )
	local New = Decorator:extend()
	New.name = name
	New.behavior = behavior
	return New
end

function Decorator.update( self, dt, context )
	return Decorator.super.update( self, dt, context )
end

return Decorator