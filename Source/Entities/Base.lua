local Class = require 'Utilities.Class'
local State = require 'Utilities.State'
local Base = Class:Extend()

Base.x, Base.y = 0, 0
Base.Rotation = 0
Base.ScaleX, Base.ScaleY = 1, 1
Base.OffsetX, Base.OffsetY = 0, 0
Base.ShearingX, Base.ShearingY = 0, 0

Base.StateStack = {}
Base.State = nil

-- x
function Base.SetX( Self, x ) Self.x = x; return Self end
function Base.GetX( Self ) return Self.x end
-- y
function Base.SetY( Self, y ) Self.y = y; return Self end
function Base.GetY( Self ) return Self.y end
-- Position
function Base.SetPosition( Self, x, y ) Self.x, Self.y = x, y; return Self end
function Base.GetPosition( Self ) return Self.x, Self.y end
-- Rotation
function Base.SetRotation( Self, Rotation ) Self.Rotation = Rotation; return Self end
function Base.GetRotation( Self ) return Self.Rotation end
-- Scale x
function Base.SetScaleX( Self, ScaleX ) Self.ScaleX = ScaleX; return Self end
function Base.GetScaleX( Self ) return Self.ScaleX end
-- Scale y
function Base.SetScaleY( Self, ScaleY ) Self.ScaleY = ScaleY; return Self end
function Base.GetScaleY( Self ) return Self.ScaleY end
-- Scale
function Base.SetScale( Self, ScaleX, ScaleY ) Self.ScaleX, Self.ScaleY = ScaleX, ScaleY; return Self end
function Base.GetScale( Self ) return Self.ScaleX, Self.ScaleY end
-- Offset x
function Base.SetOffsetX( Self, OffsetX ) Self.OffsetX = OffsetX; return Self end
function Base.GetOffsetX( Self ) return Self.OffsetX end
-- Offset y
function Base.SetOffsetY( Self, OffsetY ) Self.OffsetY = OffsetY; return Self end
function Base.GetOffsetY( Self ) return Self.OffsetY end
-- Offset
function Base.SetOffset( Self, OffsetX, OffsetY ) Self.OffsetX, Self.OffsetY = OffsetX, OffsetY; return Self end
function Base.GetOffset( Self ) return Self.OffsetX, Self.OffsetY end
-- Shearing x
function Base.SetShearingX( Self, ShearingX ) Self.ShearingX = ShearingX; return Self end
function Base.GetShearingX( Self ) return Self.ShearingX end
-- Shearing y
function Base.SetShearingY( Self, ShearingY ) Self.ShearingY = ShearingY; return Self end
function Base.GetShearingY( Self ) return Self.ShearingY end
-- Shearing
function Base.SetShearing( Self, ShearingX, ShearingY ) Self.ShearingX, Self.ShearingY = ShearingX, ShearingY; return Self end
function Base.GetShearing( Self ) return Self.ShearingX, Self.ShearingY end
-- Quad Image
function Base.SetQuadImage( Self, Image ) Self.QuadImage = Image; return Self end
function Base.GetQuadImage( Self ) return SelfQuadImage end
-- Drawing Values
function Base.SetDrawingValues( Self, x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY ) 
	Self.x, Self.y, Self.Rotation, Self.ScaleX, Self.ScaleY, Self.OffsetX, Self.OffsetY, Self.ShearingX, Self.ShearingY = x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY
	return Self 
end
function Base.GetDrawingValues( Self ) return Self.x, Self.y, Self.Rotation, Self.ScaleX, Self.ScaleY, Self.OffsetX, Self.OffsetY, Self.ShearingX, Self.ShearingY end
-- States
function Base.SetState( Self, To ) Self.State = State.Set( Self.StateStack, To ); return Self end
function Base.GetState( Self ) return State.GetCurrentState( Self.StateStack ) end
function Base.Pop( Self ) State.Pop( Self.StateStack ); return Self end

return Base