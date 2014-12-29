local Base = require 'Source.Entities.Base'
local Globals = require 'Utilities.Globals'
local Map = Base:extend()

function Map.new( data, references, quad, imageWidth, imageHeight )
	local new = Map:extend()
	
	new.data = data
	new.references = references 
	new.quadImage = quad or nil
	
	local _type = references[1]:type()
	new.imageWidth = ( _type == 'image' and references[1]:getWidth() ) or imageWidth
	new.imageHeight = ( _type == 'image' and references[1]:getHeight() ) or imageHeight
	
	new.__type = 'Map'
	
	return new
end

-- data
function Map.setData( self, data ) self.data = data return self end
function Map.getData( self, data ) return self.data end
-- references
function Map.setReferences( self, references ) self.references = references return self end
function Map.getReferences( self ) return self.references end
-- Width
function Map.setImageWidth( self, width ) self.imageWidth = width return self end
function Map.getImageWidth( self ) return self.imageWidth end
-- Height
function Map.setImageHeight( self, height ) self.imageHeight = height return self end
function Map.getImageHeight( self ) return self.imageHeight end
-- Tiles
function Map.getTileIndex( self, x, y ) 
	local x = math.ceil( ( x - self.x ) / self.imageWidth )
	local y = math.ceil( ( y - self.y ) / self.imageHeight )
	local boolean = not not ( self.data[y] and self.data[y][x] ) 
	return boolean and x, boolean and y 
end
function Map.setTile( self, x, y, Index ) self.data[y][x] = Index return self end
function Map.getTile( self, x, y ) return ( self.data[y] and self.data[x] ) and self.data[y][x] end

-- Draw
function Map.draw( self )
	local X, Y, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY = self:getDrawingValues()
	for y, row in ipairs( self.data ) do
		for x, value in ipairs( row ) do
			local image = self.references[value]
			local TileX, TileY = self.imageWidth * ( x - 1 ) + X, self.imageHeight * ( y - 1 ) + Y
			if image:type() == 'image' then 
				love.graphics.draw( image, TileX, TileY, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY )
			else -- quad / Error Checking
				love.graphics.draw( self.quadImage, image, TileX, TileY, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY )
			end
		end
	end
end

return Map