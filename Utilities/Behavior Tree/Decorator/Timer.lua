local Decorator = require 'Utilities.Behavior Tree.Decorator.Decorator'
local Timer = Decorator:extend()

function Timer.new( name, behavior, duration )
	local New = Timer:extend()
	local self = Timer.super.new( New, 'timer', behavior )
	self.duration = duration
	self.ready = false
	self.time = 0
	return self
end

function Timer.update( self, dt, context )
	return Timer.super.update( self, dt, context )
end

function Timer.start( self )
	self.ready = false
	self.time = 0
end

function Timer.finish( self )
	self.ready = false
end

function Timer.run( self, dt, context )
	self.time = self.time + dt
	if self.time >= self.duration then self.ready = true end
	if self.ready then 
		local status = self.behavior.update( self, dt, context )
		return status
	else 
		return 'running' 
	end
end

return Timer