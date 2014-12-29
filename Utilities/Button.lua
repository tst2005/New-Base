local Base = require 'Source.Entities.Base'
local Button = Base:extend()
local Globals = require 'Utilities.Globals'

function Button.new( text, x, y, font )
	local new = Button:extend()
	
	new.x = x
	new.y = y
	new.font = font or love.graphics.getFont()
	new.text = text
	new.width, new.height = new.font:getWidth( new.text ), new.font:getHeight( new.text )
	new.onSelect = function() end
	new.onHover = function() end
	new.offHover = function() end
	new.notHover = function() end
	new.keys = {}
	new.mouse = {}
	new.color = { 255, 255, 255, 255 }
	new.isMouseEnabled = true
	new.isKeyboardEnabled = true
	
	new.widthSet = false
	new.heightSet = false
	
	new.isHovering = false
	new.wasHovering = false
	
	new.__type = 'Button'
	
	return new
end

function Button.draw( self )
	love.graphics.setColor( self.color )
	love.graphics.setFont( self.font )
	love.graphics.print( self.text, unpack{ self:getDrawingValues() } )
end

function Button.update( self, dt )
	if self.isMouseEnabled then
		local mouseX, mouseY = love.mouse.getX(), love.mouse.getY()
		if Globals.boundingBox( mouseX, mouseY, self.x, self.y, self.width, self.height ) then
			self.isHovering = true
		else 
			self.isHovering = false
		end
	end
	if self.isHovering then
		self.wasHovering = true
		self:onHover()
	elseif not self.isHovering and not self.wasHovering then
		self:notHover()
	elseif self.wasHovering and not self.isHovering then
		local over = self:offHover()
		if over then
			self.wasHovering = false
		end
	end
end

-- font
function Button.setfont( self, font )
	self.font = font
	if not self.widthSet then self:setWidth( self.font:getWidth( self.text ) ) end
	if not self.heightSet then self:setHeight( self.font:getHeight( self.text ) ) end
	return self
end
function Button.getfont( self ) return self.font end
-- text
function Button.setText( self, text )
	self.text = text
	if not self.widthSet then self:setWidth( self.font:getWidth( self.text ) ) end
	if not self.getWidth then self:setHeight( self.font:getHeight( self.text ) ) end
	return self
end
function Button.getText( self ) return self.text end
-- width
function Button.setWidth( self, width ) self.width, self.widthSet = width, true; return self end
function Button.getWidth( self ) return self.width end
-- height
function Button.setHeight( self, height ) self.height, self.heightSet = height, true; return self end
function Button.getHeight( self ) return self.height end
-- Dimensions
function Button.setDimensions( self, width, height ) self.width, self.height, self.widthSet, self.heightSet = width, height, true, true; return self end
function Button.getDimensions( self ) return self.width, self.height end
-- On Select
function Button.setOnSelect( self, func ) self.onSelect = func; return self end
function Button.getOnSelect( self ) return self.onSelect end
-- On Hover
function Button.setOnHover( self, func ) self.onHover = func; return self end
function Button.getOnHover( self ) return self.onHover end
-- Off Hover
function Button.setOffHover( self, func ) self.offHover = func; return self end
function Button.getOffHover( self ) return self.offHover end
-- Not Hover
function Button.setNotHover( self, func ) self.notHover = func; return self end
function Button.getNotHover( self ) return self.notHover end
-- Bind keys
function Button.BindKey( self, key, func ) self.keys[key] = func; return self end
function Button.UnbindKey( self, key ) self.keys[key] = nil; return self end
function Button.getKeyBinding( self, key ) return self.keys[key] end
-- Bind mouse
function Button.BindMouse( self, b, func ) self.mouse[b] = func; return self end
function Button.UnbindMouse( self, b ) self.mouse[b] = nil; return self end
function Button.getMouseBinding( self, b ) return self.mouse[b] end
-- isMouseEnabled
function Button.setMouseEnabled( self, Enabled ) self.isMouseEnabled = Enabled; return self end
function Button.IsMouseEnabled( self ) return self.isMouseEnabled end
-- isKeyboardEnabled
function Button.setKeyboardEnabled( self, Enabled ) self.isKeyboardEnabled = Enabled; return self end
function Button.IsKeyboardEnabled( self ) return self.isKeyboardEnabled end
-- mouse Select
function Button.setOnSelect( self, func ) self.onSelect = func; return self end
function Button.getOnSelect( self ) return self.onSelect end

-- center
function Button.centerX( self ) self.x = ( Globals.screenWidth - self.width ) / 2 end
function Button.centerY( self ) self.y = ( Globals.screenHeight - self.height ) / 2 end
function Button.center( self ) 
	self:centerX()
	self:centerY()
end

-- mouse pressed
function Button.mousePressed( self, x, y, b ) 
	local func = self.mouse[b] 
	if func and self.isMouseEnabled then
		func( self, 'onPress', x, y )
	end
end
-- mouse released
function Button.mouseReleased( self, x, y, b ) 
	local func = self.mouse[b] 
	if func and self.isMouseEnabled then
		func( self, 'onRelease', x, y )
	end
end
-- key pressed
function Button.keyPressed( self, key, isRepeat ) 
	local func = self.keys[key]
	if func and self.isKeyboardEnabled then
		func( self, 'onPress', key, isRepeat )
	end
end
-- key released
function Button.keyReleased( self, key, isRepeat ) 
	local func = self.keys[key] 
	if func and self.isKeyboardEnabled then
		func( self, 'onRelease', key, isRepeat )
	end
end

return Button