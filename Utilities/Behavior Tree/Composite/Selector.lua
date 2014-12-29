local Behavior = require 'Utilities.Behavior Tree.Behavior'
local Selector = Behavior:extend()

function Selector.new( name, ... )
	New = Selector:extend()
	New.name = name
	New.nodes = { ... }
	New.currentNode = 1
	return New
end

function Selector.update( self, dt, context )
	return Selector.super.update( self, dt, context )
end

function Selector.start( self, context )
	self.currentNode = 1
end

function Selector.finish( self )
end

function Selector.run( self, dt, context )
	while true do
		local status = self.nodes[self.currentNode]:update( dt, context	)
		if status ~= 'failure' then return status end
		self.currentNode = self.currentNode + 1
		if self.currentNode > #self.nodes then return 'failure' end
	end
end

return Selector