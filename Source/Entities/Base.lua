local Class = require 'Utilities.Class'
local Base = Class:Extend()

Base.x, Base.y = 0, 0
Base.Rotation = 0
Base.ScaleX, Base.ScaleY = 1, 1
Base.OffsetX, Base.OffsetY = 0, 0
Base.ShearingX, Base.ShearingY = 0, 0

function Base.New( x, y ) 
	local New = Base:Extend()
	New.x = x 
	New.y = y
	return New
end
-- x
function Base.SetX( Self, x ) Self.x = x end
function Base.GetX( Self ) return Self.x end
-- y
function Base.SetY( Self, y ) Self.y = y end
function Base.GetY( Self ) return Self.y end
-- Position
function Base.SetPosition( Self, x, y ) Self.x, Self.y = x, y end
function Base.GetPosition( Self ) return Self.x, Self.y end
-- Rotation
function Base.SetRotation( Self, Rotation ) Self.Rotation = Rotation end
function Base.GetRotation( Self ) return Self.Rotation end
-- Scale x
function Base.SetScaleX( Self, ScaleX ) Self.ScaleX = ScaleX end
function Base.GetScaleX( Self ) return Self.ScaleX end
-- Scale y
function Base.SetScaleY( Self, ScaleY ) Self.ScaleY = ScaleY end
function Base.GetScaleY( Self ) return Self.ScaleY end
-- Scale
function Base.SetScale( Self, ScaleX, ScaleY ) Self.ScaleX, Self.ScaleY = ScaleX, ScaleY end
function Base.GetScale( Self ) return Self.ScaleX, Self.ScaleY end
-- Offset x
function Base.SetOffsetX( Self, OffsetX ) Self.OffsetX = OffsetX end
function Base.GetOffsetX( Self ) return Self.OffsetX end
-- Offset y
function Base.SetOffsetY( Self, OffsetY ) Self.OffsetY = OffsetY end
function Base.GetOffsetY( Self ) return Self.OffsetY end
-- Offset
function Base.SetOffset( Self, OffsetX, OffsetY ) Self.OffsetX, Self.OffsetY = OffsetX, OffsetY end
function Base.GetOffset( Self ) return Self.OffsetX, Self.OffsetY end
-- Shearing x
function Base.SetShearingX( Self, ShearingX ) Self.ShearingX = ShearingX end
function Base.GetShearingX( Self ) return Self.ShearingX end
-- Shearing y
function Base.SetShearingY( Self, ShearingY ) Self.ShearingY = ShearingY end
function Base.GetShearingY( Self ) return Self.ShearingY end
-- Shearing
function Base.SetShearing( Self, ShearingX, ShearingY ) Self.ShearingX, Self.ShearingY = ShearingX, ShearingY end
function Base.GetShearing( Self ) return Self.ShearingX, Self.ShearingY end
-- Quad Image
function Base.SetQuadImage( Self, Image ) Self.QuadImage = Image end
function Base.GetQuadImage( Self ) return SelfQuadImage end
-- Drawing Values
function Base.SetDrawingValues( Self, x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY ) Self.x, Self.y, Self.Rotation, Self.ScaleX, Self.ScaleY, Self.OffsetX, Self.OffsetY, Self.ShearingX, Self.ShearingY = x, y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY end
function Base.GetDrawingValues( Self ) return Self.x, Self.y, Self.Rotation, Self.ScaleX, Self.ScaleY, Self.OffsetX, Self.OffsetY, Self.ShearingX, Self.ShearingY end

return Base