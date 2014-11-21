local Tween = require 'Utilities.Tween'
local camera = require 'Utilities.Third Party.camera'
local Camera = {}
Camera.__index = Camera
setmetatable( Camera, camera )

-- hump.camera functions
function Camera.New( x, y, Rotation, Zoom )
	local New = camera.new( x, y, Rotation, Zoom )
	New.__index = Camera
	setmetatable( New, Camera )
	return New
end

function Camera.Move( Self, DirectionX, DirectionY ) Self:move( DirectionX, DirectionY ); return Self end
function Camera.SetPosition( Self, x, y ) Self:lookAt( x, y ); return Self end
function Camera.GetPosition( Self ) return Self:pos() end
function Camera.Rotate( Self, Amount ) Self:rotate( Amount ); return Self end
function Camera.SetRotation( Self, Angle ) Self:rotateTo( Amount ); return Self end
function Camera.Scale( Self, Scale ) Self:zoom( Scale ); return Self end
function Camera.SetScale( Self, Scale ) Self:zoomTo( Scale ); return Self end
function Camera.PreDraw( Self ) Self:attach(); return Self end
function Camera.PostDraw( Self ) Self:detach(); return Self end
function Camera.Draw( Self, Function ) Self:draw( Function ) end
function Camera.GetWorldCoordinates( Self ) return Self:worldCoords() end
function Camera.GetCameraCoordinates( Self ) return Self:cameraCoords() end
function Camera.GetMousePosition( Self ) return Self:mousepos() end

function Camera.SetPreDraw( Self, Function ) Self.attach = function( Self ) Function( Self ) end end
function Camera.SetPostDraw( Self, Function ) Self.detach = function( Self ) Function( Self ) end end
function Camera.GetRotation( Self ) return Self.rot end
function Camera.GetScale( Self ) return Self.scale end
-- Easing Movement
function Camera.EaseTo( Self, Time, x, y, Easing )
	Self.Tween = Tween.New( Time, Self, { x = x, y = y }, Easing )
end

function Camera.Update( Self, dt )
	if Self.Tween then Self.Tween:Update( dt ) end
end

return Camera