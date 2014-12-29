local Class = require 'Utilities.Class'
local State = require 'Utilities.State'
local Base = Class:extend()

Base.x, Base.y = 0, 0
Base.rotation = 0
Base.scaleX, Base.scaleY = 1, 1
Base.offsetX, Base.offsetY = 0, 0
Base.shearingX, Base.shearingY = 0, 0
Base.__type = 'Base'

-- x
function Base.setX( self, x ) self.x = x; return self end
function Base.getX( self ) return self.x end
-- y
function Base.setY( self, y ) self.y = y; return self end
function Base.getY( self ) return self.y end
-- Position
function Base.setPosition( self, x, y ) self.x, self.y = x, y; return self end
function Base.getPosition( self ) return self.x, self.y end
-- Rotation
function Base.setRotation( self, Rotation ) self.rotation = rotation; return self end
function Base.getRotation( self ) return self.rotation end
-- Scale x
function Base.setScaleX( self, scaleX ) self.scaleX = scaleX; return self end
function Base.getScaleX( self ) return self.scaleX end
-- Scale y
function Base.setScaleY( self, scaleY ) self.scaleY = scaleY; return self end
function Base.getScaleY( self ) return self.scaleY end
-- Scale
function Base.setScale( self, scaleX, scaleY ) self.scaleX, self.scaleY = scaleX, scaleY; return self end
function Base.getScale( self ) return self.scaleX, self.scaleY end
-- Offset x
function Base.setOffsetX( self, offsetX ) self.offsetX = offsetX; return self end
function Base.getOffsetX( self ) return self.offsetX end
-- Offset y
function Base.setOffsetY( self, offsetY ) self.offsetY = offsetY; return self end
function Base.getOffsetY( self ) return self.offsetY end
-- Offset
function Base.setOffset( self, offsetX, offsetY ) self.offsetX, self.offsetY = offsetX, offsetY; return self end
function Base.getOffset( self ) return self.offsetX, self.offsetY end
-- Shearing x
function Base.setShearingX( self, shearingX ) self.shearingX = shearingX; return self end
function Base.getShearingX( self ) return self.shearingX end
-- Shearing y
function Base.setShearingY( self, shearingY ) self.shearingY = shearingY; return self end
function Base.getShearingY( self ) return self.shearingY end
-- Shearing
function Base.setShearing( self, shearingX, shearingY ) self.shearingX, self.shearingY = shearingX, shearingY; return self end
function Base.getShearing( self ) return self.shearingX, self.shearingY end
-- Quad Image
function Base.setQuadImage( self, image ) self.quadImage = image; return self end
function Base.getQuadImage( self ) return self.quadImage end
-- Drawing Values
function Base.setDrawingValues( self, x, y, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY ) 
	self.x, self.y, self.rotation, self.scaleX, self.scaleY, self.offsetX, self.offsetY, self.shearingX, self.shearingY 
		= x, y, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY
	return self 
end
function Base.getDrawingValues( self ) return self.x, self.y, self.rotation, self.scaleX, self.scaleY, self.offsetX, self.offsetY, self.shearingX, self.shearingY end

return Base