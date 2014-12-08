local Globals = require 'Utilities.Globals'
local cron = require 'Utilities.Third Party.cron'
local originalMeta = getmetatable( cron.after( 0, function() end ) )
local Timer = {}
Timer.__index = Timer
setmetatable( Timer, originalMeta )

local function setMetatable( original, meta )
	original.active = true
	original.__index = meta
	setmetatable( original, meta )
end

-- cron.lua functions
function Timer.after( time, callback, ... )
	local New = cron.after( time, callback, ... )
	setMetatable( New, Timer )
	return New
end

function Timer.every( time, callback, ... )
	local New = cron.every( time, callback, ... )
	setMetatable( New, Timer )
	return New
end

function Timer.stopwatch()
	local New = { 
		active = true, 
		running = 0, 
		update = function( self, dt )
			if self.active then
				self.running = self.running + dt
			end
		end, 
	}
	New.__index = Timer
	setmetatable( New, Timer )
	return New
end

function Timer.update( self, dt ) if self.active then self.active = not cron.update( self, dt ) end; return self.active end
function Timer.reset( self, running ) self.active = true; cron.reset( self, running ) end
-- time
function Timer.getTime( self ) return self.running end
-- Activity
function Timer.isActive( self ) return self.active end
function Timer.pause( self ) self.active = false; return self end
function Timer.resume( self ) self.active = true; return self end
-- Duration
function Timer.setDuration( self, time ) self.time = time; return self end
function Timer.getDuration( self ) return self.time end
-- Callbacks
function Timer.setCallbacks( self, func ) self.callback = func; return self end
function Timer.getCallbacks( self ) return self.callback end
-- Arguments
function Timer.setArguments( self, ... ) self.args = Globals.checkUserdata( ... ); return self end
function Timer.getArguments( self ) return self.args end

return Timer