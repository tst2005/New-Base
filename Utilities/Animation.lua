local Base = require 'Source.Entities.Base'
local Timer = require 'Utilities.Timer'
local Animation = Base:Extend()

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

local function CheckForQuads( Images, Quad )
	for Index = 1, #Images do
		local Type = Images[Index]:type()
		assert( Quad and Type, 'Animation Error: Quad-images passed with no Quad reference!' )
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
	New.EntireTime = 0
	New.OnComplete = function() end
	New.TimesRepeated = 0
	
	CheckForQuads( New.Images, New.Quad )

	return New
end

function Animation.Reload( Self )
	Self.Timer = Timer.After( Self.Delays[Self.Index], ChangeIndex, Self )
	Self.Image = Self.Images[Self.Index]
end

function Animation.Update( Self, dt )
	if Self.Active then
		Self.TotalElapsedTime = Self.TotalElapsedTime + dt
		Self.EntireTime = Self.EntireTime + dt
		Self.Timer:Update( dt )
	end
end

function Animation.Draw( Self )
	if Self.Active and Self.Image then
		local Type = Self.Image:type()
		
		if Type == 'Image' then
			love.graphics.draw( Self.Image, Self.x, Self.y, Self.Rotation, Self.ScaleX, Self.ScaleY, Self.OffsetX, Self.OffsetY, Self.ShearingX, Self.ShearingY )
		elseif Type == 'Quad' then
			love.graphics.draw( Self.Quad, Self.Image, Self.x, Self.y, Self.Rotation, Self.ScaleX, Self.ScaleY, Self.OffsetX, Self.OffsetY, Self.ShearingX, Self.ShearingY )
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
-- Total Elapsed Time
function Animation.SetTotalElapsedTime( Self, Time ) Self.TotalElapsedTime = Time; return Self end
function Animation.GetTotalElapsedTime( Self ) return Self.TotalElapsedTime end
-- Entire Time
function Animation.SetEntireTime( Self, Time ) Self.EntireTime = Time; return Self end
function Animation.GetEntireTime( Self ) return Self.EntireTime end
-- On Complete
function Animation.SetOnComplete( Self, Function ) Self.OnComplete = Function end
function Animation.GetOnComplate( Self ) return Self.OnComplete end

return Animation