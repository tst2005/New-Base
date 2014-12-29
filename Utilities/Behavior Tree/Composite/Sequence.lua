local Behavior = require 'Utilities.Behavior Tree.Behavior'
local Sequence = Behavior:extend()

function Sequence.new( name, ... )
	New = Sequence:extend()
	New.name = name
	New.nodes = { ... }
	New.currentNode = 1
	return New
end

function Sequence.update( self, dt, context )
	return Sequence.super.update( self, dt, context )
end

function Sequence.start( self, context )
	self.currentNode = 1
end

function Sequence.finish( self )
end

function Sequence.run( self, dt, context )
	while true do
		local status = self.nodes[self.currentNode]:update( dt, context	)
		if status ~= 'success' then return status end
		
		self.currentNode = self.currentNode + 1
		if self.currentNode > #self.nodes then return status end
	end
end

return Sequence