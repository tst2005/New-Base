local Decorator = require 'Utilities.Behavior Tree.Decorator.Decorator'
local Inverter = Decorator:extend()

function Inverter.new( behavior )
	local New = Inverter:extend()
	return Inverter.super.new( New, 'Inverter', behavior )
end

function Inverter.update( self, dt, context )
	return Inverter.super.update( self, dt, context )
end

function Inverter.start( self )
end

function Inverter.finish( self )
end

function Inverter.run( self, dt, context )
	local status = self.behavior.update( dt, context )
	if status == 'running' then return 'running'
	elseif status == 'success' then return 'failure'
	elseif status == 'failure' then return 'success' end
end

return Inverter