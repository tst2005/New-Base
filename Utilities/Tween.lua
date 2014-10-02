local Class = require 'Utilities.Class'
local Timer = require 'Utilities.Timer'
local Tween = Class:Extend()

function Tween.New()
	local New = Tween:Extend()
	New.Start, New.End, New.Function = nil, nil, nil
	New.CurrentValue = New.Start
	New.Timer = Timer.New() -- This line.
	New.Active = true
	return New
end

-- Start
function Tween.SetStart( Self, Value ) Self.Start, Self.CurrentValue = Value, Value end
function Tween.GetStart( Self ) return Self.Start end
-- End
function Tween.SetEnd( Self, Value ) Self.End = Value end
function Tween.GetEnd( Self ) return Self.End end
-- Function
function Tween.SetFunction( Self, Function ) Self.Function = Function end
function Tween.GetFunction( Self ) return Self.Function end
-- CurrentValue
function Tween.SetCurrentValue( Self, Value ) Self.CurrentValue = Value end
function Tween.GetCurrentValue( Self ) return Self.CurrentValue end
-- Timer
function Tween.SetTimer( Self, Time ) Self.Timer:SetTime( Time ) end
function Tween.GetTimer( Self ) return Self.Timer:GetTime() end
-- Active
function Tween.Resume( Self ) Self.Timer:Resume() end
function Tween.Pause( Self ) Self.Timer:Pause() end
function Tween.Stop( Self ) Self.Timer:Stop(); Self.CurrentValue = Self.Start end
function Tween.Start( Self ) Self.Timer:Start(); Self.CurrentValue = Self.Start end

-- Update
function Tween.Update( Self, dt )
	if Self.Active then
		Self.Timer:Update( dt )
		Self.CurrentValue = Self.Function( Self.Timer:GetTime() )
		
		if Self.CurrentValue > Self.End then
			Self:Stop()
		end
	end
	return Self.CurrentValue
end

return Tween