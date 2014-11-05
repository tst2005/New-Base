local Class = require 'Utilities.Class'
local Timer = require 'Utilities.Timer'
local Animation = Class:Extend()

local DefaultDrawingValues = {
	0, 0, 	-- x, y
	0, 		-- Rotation
	1, 1, 	-- Scale x, Scale y
	0, 0, 	-- Offset x, Offset y
	0, 0, 	-- Shearing x, Shearing y
}

local function ChangeIndex( Self, Iterator )
	Iterator = Iterator or 1
	Self.Index = Self.Index + Iterator
	
	if Self.Delays[Self.Index] then
		Self:Reload()
	else
		if Self.Looping then
			Self.TimesRepeated = Self.TimesRepeated + 1
			Self.TotalElapsedTime = 0
			Self.Index = 1
			Self:Reload()
		end
		Self.OnComplete( Self.TimesRepeated )
	end
end

function Animation.New( Images, Delays, Quad ) 
	local New = Animation:Extend() 
	New.Images = Images
	New.Delays = Delays
	New.Length = #New.Images
	New.Index = 1
	New.Looping = false
	New.Quad = Quad or nil
	New.Active = true
	New.Timer = Timer.After( Delays[New.Index], ChangeIndex, New )
	New.Image = New.Images[1]
	New.TotalElapsedTime = 0 	-- NOTE: Resets on-loop.
	New.OnComplete = nil
	New.TimesRepeated = 0
	
	New.Values = setmetatable( {}, 
		{ 
			__index = function( Table, Key )
				return DefaultDrawingValues[Key]
			end
		} 
	)
	
	return New
end

function Animation.Reload( Self )
	Self.Timer = Timer.After( Self.Delays[Self.Index], ChangeIndex, Self )
	Self.Image = Self.Images[Self.Index]
end

function Animation.Update( Self, dt )
	if Self.Active then
		Self.TotalElapsedTime = Self.TotalElapsedTime + dt
		Self.Timer:Update( dt )
	end
end

function Animation.Draw( Self )
	if Self.Active and Self.Image then
		local Type = Self.Image:type()
		local x, y = Self.Values[1], Self.Values[2]
		local Rotation = Self.Values[3]
		local ScaleX, ScaleY = Self.Values[4], Self.Values[5]
		local OffsetX, OffsetY = Self.Values[6], Self.Values[7]
		local ShearingX, ShearingY = Self.Values[8], Self.Values[9]
		
		if Type == 'Image' then
			love.graphics.draw( Self.Image, x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY )
		elseif Type == 'Quad' then
			love.graphics.draw( Self.Quad, Self.Image, x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY )
		end
	end
end

-- Images
function Animation.SetImages( Self, Images ) Self.Images = Images; return Self end
function Animation.GetImages( Self ) return Self.Images end
-- Delays
function Animation.SetDelays( Self, Delays ) Self.Delays = Delays; return Self end
function Animation.GetDelays( Self ) return Self.Delays end
-- Length
function Animation.SetLength( Self, Length ) Self.Length = Length; return Self end
function Animation.GetLength( Self ) return Self.Length end
-- Index
function Animation.SetIndex( Self, Index ) Self.Index = Index; return Self end
function Animation.GetIndex( Self ) return Self.Index end
-- Looping
function Animation.SetLooping( Self, Looping ) if Looping == nil then Self.Looping = true else Self.Looping = Looping end; return Self end
function Animation.IsLooping( Self ) return Self.Looping end
-- Quad
function Animation.SetQuadImage( Self, QuadImage ) Self.Quad = QuadImage; return Self end
function Animation.GetQuadImage( Self ) return Self.QuadImage end
-- Active
function Animation.SetActive( Self, Active ) Self.Active = Active; return Self end
function Animation.GetActive( Self ) return Self.Active end
-- Timer
function Animation.SetTimer( Self, Timer ) Self.Timer = Timer; return Self end
function Animation.GetTimer( Self ) return Self.Timer end
-- Image
function Animation.SetCurrentImage( Self, CurrentImage ) Self.Image = CurrentImage; return Self end
function Animation.GetCurrentImage( Self ) return Self.CurrentImage end
-- Values
function Animation.SetDrawingValues( Self, Values ) Self.Values = Values; return Self end
function Animation.GetDrawingValues( Self ) return Self.Values end
-- Values x
function Animation.SetX( Self, x ) Self.Values[1] = x; return Self end
function Animation.GetX( Self ) return Self.Values[1] end
-- Values y
function Animation.SetY( Self, y ) Self.Values[2] = y; return Self end
function Animation.GetY( Self ) return Self.Values[2] end
-- Values Position
function Animation.SetPositions( Self, x, y ) Self.Values[1], Self.Values[2] = x, y; return Self end
function Animation.GetPositions( Self ) return Self.Values[1], Self.Values[2] end
-- Values Rotation
function Animation.SetRotation( Self, Rotation ) Self.Values[3] = Rotation; return Self end
function Animation.GetRotation( Self ) return Self.Values[3] end
-- Values Scale x
function Animation.SetScaleX( Self, ScaleX ) Self.Values[4] = ScaleX; return Self end
function Animation.GetScaleX( Self ) return Self.Values[4] end
-- Values Scale y
function Animation.SetScaleY( Self, ScaleY ) Self.Values[5] = ScaleY; return Self end
function Animation.GetScaleY( Self ) return Self.Values[5] end
-- Values Scale
function Animation.SetScale( Self, x, y ) Self.Values[4], Self.Values[5] = x, y; return Self end
function Animation.GetScale( Self ) return Self.Values[4], Self.Values[5] end
-- Values Offset x
function Animation.SetOffsetX( Self, OffsetX ) Self.Values[6] = OffsetX; return Self end
function Animation.GetOffsetX( Self ) return Self.Values[6] end
-- Values Offset y
function Animation.SetOffsetY( Self, OffsetY ) Self.Values[7] = OffsetY; return Self end
function Animation.GetOffsetY( Self ) return Self.Values[7] end
-- Values Offset
function Animation.SetOffset( Self, x, y ) Self.Values[6], Self.Values[7] = x, y; return Self end
function Animation.GetOffset( Self ) return Self.Values[6], Self.Values[7] end
-- Values Shearing x
function Animation.SetShearingX( Self, ShearingX ) Self.Values[8] = ShearingX; return Self end
function Animation.GetShearingX( Self ) return Self.Values[8] end
-- Values Shearing y
function Animation.SetShearingY( Self, ShearingY ) Self.Values[9] = ShearingY; return Self end
function Animation.GetShearingY( Self ) return Self.Values[9] end
-- Values Shearing
function Animation.SetShearing( Self, x, y ) Self.Values[8], Self.Values[9] = x, y; return Self end
function Animation.GetShearing( Self ) return Self.Values[8], Self.Values[9] end
-- Total Elapsed Time
function Animation.SetTotalElapsedTime( Self, Time ) Self.TotalElapsedTime = Time; return Self end
function Animation.GetTotalElapsedTime( Self ) return Self.TotalElapsedTime end
-- On Complete
function Animation.SetOnComplete( Self, Function ) Self.OnComplete = Function end
function Animation.GetOnComplate( Self ) return Self.OnComplete end

return Animation