local Behavior = require 'Utilities.Behavior Tree.Behavior'
local Root = Behavior:extend()

function Root.new( object, behavior )
	local New = Root:extend()
	New.object = object
	New.behavior = behavior
	New.context = { object = New.object }
	return New
end

function Root.update( self, dt )
	return Root.super.update( self, dt )
end

function Root.start( self )
	self.context = { object = self.object }
end

function Root.finish( self, status )
end

function Root.run( self, dt )
	return self.behavior:update( dt, self.context )
end

return Root