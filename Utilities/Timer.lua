local Globals = require 'Utilities.Globals'
local cron = require 'Utilities.Third Party.cron'
local OriginalMeta = getmetatable( cron.after( 0, function() end ) )
local Timer = {}
Timer.__index = Timer
setmetatable( Timer, OriginalMeta )

local function SetMetaTable( Original, Meta )
	Original.Active = true
	Original.__index = Meta
	setmetatable( Original, Meta )
end

-- cron.lua functions
function Timer.After( Time, Callback, ... )
	local New = cron.after( Time, Callback, ... )
	SetMetaTable( New, Timer )
	return New
end

function Timer.Every( Time, Callback, ... )
	local New = cron.every( Time, Callback, ... )
	SetMetaTable( New, Timer )
	return New
end

function Timer.Update( Self, dt ) if Self.Active then Self.Active = not Self:update( dt ) end; return Self.Active end
function Timer.Reset( Self, Running ) Self.Active = true; Self:reset( Running ) end
-- Time
function Timer.GetTime( Self ) return Self.running end
-- Activity
function Timer.IsActive( Self ) return Self.Active end
function Timer.Pause( Self ) Self.Active = false; return Self end
function Timer.Resume( Self ) Self.Active = true; return Self end
-- Duration
function Timer.SetDuration( Self, Time ) Self.time = Time; return Self end
function Timer.GetDuration( Self ) return Self.time end
-- Callbacks
function Timer.SetCallback( Self, Function ) Self.callback = Function; return Self end
function Timer.GetCallback( Self ) return Self.callback end
-- Arguments
function Timer.SetArguments( Self, ... ) Self.args = Globals.CheckUserdata( ... ); return Self end
function Timer.GetArguments( Self ) return Self.args end

return Timer