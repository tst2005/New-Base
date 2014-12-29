local Decorator = require 'Utilities.Behavior Tree.Decorator.Decorator'
local Succeeder = Decorator:extend()

function Succeeder.new( behvaior )
	local New = Succeeder:extend()
	return Succeeder.super.new( New, 'Succeeder', behvaior )
end

function Succeeder.update( self, dt, context )
	return Succeeder.super.update( self, dt, context )
end

function Succeeder.start( self )
end

function Succeeder.finish( self )
end

function Succeeder.run( self, dt, context )
	self.behavior.update( dt, context )
	return 'success'
end

return Succeeder