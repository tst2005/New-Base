local Base = require 'Source.Entities.Base'
local Globals = require 'Utilities.Globals'
local Map = Base:Extend()

function Map.New( Data )
	local New = Map:Extend()
	New.x, New.y, New.Rotation, New.ScaleX, New.ScaleY, New.OffsetX, New.OffsetY, New.ShearingX, New.ShearingY = 0, 0, 0, 1, 1, 0, 0, 0, 0
	New.Data = Data
	New.References = {}
	New.QuadImage = nil
	New.ImageWidth = nil
	New.ImageHeight = nil
	return New
end

-- Data
function Map.SetData( Self, Data ) Self.Data = Data end
function Map.GetData( Self, Data ) return Self.Data end
-- References
function Map.SetReferences( Self, References ) Self.References = References end
function Map.GetReferences( Self ) return Self.References end
-- Width
function Map.SetImageWidth( Self, Width ) Self.ImageWidth = Width end
function Map.GetImageWidth( Self ) return Self.ImageWidth end
-- Height
function Map.SetImageHeight( Self, Height ) Self.ImageHeight = Height end
function Map.GetImageHeight( Self ) return Self.ImageHeight end
-- Tiles
function Map.GetTileIndex( Self, x, y ) 
	local x = math.ceil( ( x - Self.x ) / Self.ImageWidth )
	local y = math.ceil( ( y - Self.y ) / Self.ImageHeight )
	local Boolean = not not ( Self.Data[y] and Self.Data[y][x] ) 
	return Boolean and x, Boolean and y 
end
function Map.SetTile( Self, x, y, Index ) Self.Data[y][x] = Index end
function Map.GetTile( Self, x, y ) return ( Self.Data[y] and Self.Data[x] ) and Self.Data[y][x] end

-- Draw
function Map.Draw( Self )
	local X, Y, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY = Self:GetDrawingValues()
	for y, Row in ipairs( Self.Data ) do
		for x, Value in ipairs( Row ) do
			local Image = Self.References[Value]
			local TileX, TileY = Self.ImageWidth * ( x - 1 ) + X, Self.ImageHeight * ( y - 1 ) + Y
			if Image:type() == 'Image' then 
				love.graphics.draw( Image, TileX, TileY, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY )
			else -- Quad / Error Checking
				love.graphics.draw( Self.QuadImage, Image, TileX, TileY, Rotation, ScaleX, ScaleY, OffsetX, OffsetY, ShearingX, ShearingY )
			end
		end
	end
end

return Map