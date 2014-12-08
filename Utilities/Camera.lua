local Tween = require 'Utilities.Tween'
local camera = require 'Utilities.Third Party.camera'
local Camera = {}
Camera.__index = Camera
setmetatable( Camera, camera )

-- hump.camera functions
function Camera.new( x, y, rotation, zoom )
	local New = camera.new( x, y, rotation, zoom )
	New.__index = Camera
	setmetatable( New, Camera )
	return New
end

function Camera.move( self, directionX, directionY ) self:move( directionX, directionY ); return self end
function Camera.setPosition( self, x, y ) self:lookAt( x, y ); return self end
function Camera.getPosition( self ) return self:pos() end
function Camera.rotate( self, Amount ) self:rotate( Amount ); return self end
function Camera.setRotation( self, Angle ) self:rotateTo( Amount ); return self end
function Camera.scale( self, scale ) self:zoom( scale ); return self end
function Camera.setScale( self, scale ) self:zoomTo( scale ); return self end
function Camera.preDraw( self ) self:attach(); return self end
function Camera.postDraw( self ) self:detach(); return self end
function Camera.draw( self, func ) self:draw( func ) end
function Camera.getWorldCoordinates( self ) return self:worldCoords() end
function Camera.getCameraCoordinates( self ) return self:cameraCoords() end
function Camera.getMousePosition( self ) return self:mousepos() end

function Camera.setPreDraw( self, func ) self.attach = function( self ) func( self ) end end
function Camera.setPostDraw( self, func ) self.detach = function( self ) func( self ) end end
function Camera.getRotation( self ) return self.rot end
function Camera.getScale( self ) return self.scale end
-- Easing movement
function Camera.easeTo( self, time, x, y, easing )
	self.Tween = Tween.New( time, self, { x = x, y = y }, easing )
end

function Camera.update( self, dt )
	if self.tween then self.tween:update( dt ) end
end

return Camera