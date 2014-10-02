local Base = require 'Source.Entities.Base'
local Globals = require 'Utilities.Globals'
local Timer = require 'Utilities.Timer'
local Animation = Base:Extend()

function Animation.New()
	local New = Animation:Extend()
	New.x, New.y, New.Rotation, New.ScaleX, New.ScaleY, New.OffsetX, New.OffsetY, New.ShearingX, New.ShearingY = 0, 0, 0, 1, 1, 0, 0, 0, 0
	New.Images = {}
	New.Delays = {}
	New.Index = 1
	New.Active = true
	New.QuadImage = nil
	New.Timer = Timer.New()
	New.Looping = true
	return New
end

-- Images
function Animation.SetImages( Self, ... ) Self.Images = Globals.CheckUserdata( ... ) end
function Animation.GetImages( Self ) return Self.Images end
-- Delays
function Animation.SetDelays( Self, ... ) Self.Delays = Globals.CheckUserdata( ... ) end
function Animation.GetDelays( Self ) return Self.Delays end
-- Activity
function Animation.Resume( Self ) Self.Timer:Resume() end
function Animation.Pause( Self ) Self.Timer:Pause() end
function Animation.Stop( Self ) Self.Timer:Stop(); Self.Index = 1 end
function Animation.Start( Self ) Self.Timer:Start(); Self.Index = 1 end
-- Timer
function Animation.SetTimer( Self, Time ) Self.Timer:SetTime( Time ) end
function Animation.GetTimer( Self ) return Self.Timer:GetTime() end
-- Looping
function Animation.SetLooping( Self, Boolean ) Self.Looping = Boolean end
function Animation.GetLooping( Self ) return Self.Looping end
-- Index
function Animation.SetIndex( Self, Index ) Self.Index = Index end 
function Animation.GetIndex( Self ) return Self.Index end

-- Draw
function Animation.Draw( Self )
	if Self.Active then
		local Value = Self.Images[Self.Index]
		local x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY = Self:GetDrawingValues()
		
		if Value:type() == 'Image' then 
			love.graphics.draw( Value, x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY )
		else -- Quad / Error Checking.
			love.graphics.draw( Self.QuadImage, Value, x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY )
		end
	end
end

-- Update
function Animation.Update( Self, dt )
	Self.Active = Self.Timer:IsActive()
	Self.Timer:Update( dt )
	if Self.Active then
		if Self.Timer:GetTime() > Self.Delays[Self.Index] then
			Self.Index = Self.Index + 1
			if Self.Index > #Self.Delays then
				if not Self.Looping then Self.Active = false end
				Self.Index = 1
			end
			Self.Timer:Start()
		end
	end
end

return Animation