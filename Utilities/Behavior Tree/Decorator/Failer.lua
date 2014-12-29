local Decorator = require 'Utilities.Behavior Tree.Decorator.Decorator'
local Failer = Decorator:extend()

function Failer.new( behvaior )
	local New = Failer:extend()
	return Failer.super.new( New, 'Failer', behvaior )
end

function Failer.update( self, dt, context )
	return Failer.super.update( self, dt, context )
end

function Failer.start( self )
end

function Failer.finish( self )
end

function Failer.run( self, dt, context )
	self.behavior.update( dt, context )
	return 'failure'
end

return Failer