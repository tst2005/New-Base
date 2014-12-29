local Decorator = require 'Utilities.Behavior Tree.Decorator.Decorator'
local RepeatUntilFail = Decorator:extend()

function RepeatUntilFail.new( behavior, times )
	local New = RepeatUntilFail:extend()
	return RepeatUntilFail.super.new( New, 'RepeatUntilFail', behavior )
end

function RepeatUntilFail.update( self, dt, context )
	return RepeatUntilFail.super.update( self, dt, context )
end

function RepeatUntilFail.start( self )
end

function RepeatUntilFail.finish( self )
end

function RepeatUntilFail.run( self, dt, context )
	local status = self.behavior.update( dt, context )
	if status ~= 'failure' then return 'running'
	else return 'success' end
end

return RepeatUntilFail