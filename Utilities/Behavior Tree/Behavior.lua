local Class = require 'Utilities.Class'
local Behavior = Class:extend()

function Behavior.new()
	local New = Behavior:extend()
	New.status = 'uninitialized'
	return New
end

function Behavior.update( self, dt, context )
	if self.status ~= 'running' then 
		self:start( context )
	end
	self.status = self:run( dt, context )
	if self.status ~= 'running' then
		self:finish( self.status, context )
	end
	return self.status
end

return Behavior