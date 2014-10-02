local Class = require 'Utilities.Class'
local Timer = Class:Extend()

function Timer.New()
	local New = Timer:Extend()
	New.Time = 0
	New.Active = true
	New.HasStopped = false
	New.Limit = nil
	return New
end

-- Timer
function Timer.SetTime( Self, Time ) Self.Time = Time end
function Timer.GetTime( Self ) return Self.Time end
-- Activity
function Timer.Resume( Self ) Self.Active = true end
function Timer.Pause( Self ) Self.Active = false end
function Timer.Stop( Self ) Self.Active, Self.HasStopped = false, true end
function Timer.Start( Self ) Self.Active, Self.Index, Self.Time, Self.HasStopped = true, 1, 0, false end
function Timer.IsActive( Self ) return Self.Active end
-- HasStopped
function Timer.HasStopped( Self ) return Self.HasStopped end
-- Limit
function Timer.SetLimit( Self, Limit ) Self.Limit = Limit end
function Timer.GetLimit( Self ) return Self.Limit end

-- Update
function Timer.Update( Self, dt )
	if Self.Active then
		Self.Time = Self.Time + dt
		if Self.Limit and Self.Time > Self.Limit then Self:Stop() end
	end
end

return Timer