local Behavior = require 'Utilities.Behavior Tree.Behavior'
local Leaf = Behavior:extend()

function Leaf.new( name )
	local New = Leaf.super.new()
	New.name = name
	return New
end

function Leaf.update( self, dt, context )
	return Leaf.super.update( self, dt, context )
end

return Leaf