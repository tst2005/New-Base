local Base = require 'Source.Entities.Base'
local Button = require 'Utilities.Button'
local Globals = require 'Utilities.Globals'
local Menu = Button:extend()
local oldnew = Base.new

local function hasMouseMoved( self, x, y )
	if x ~= self.oldX or y ~= self.oldY then return true end
	return false
end

function Menu.new( x, y, lineSeparation, font, ... )
	local new = Menu:extend()
	
	local texts = { ... }
	
	new.x = x
	new.y = y
	new.oldMouseX, new.oldMouseY = love.mouse.getX(), love.mouse.getY()
	
	new.lineSeparation = lineSeparation or 2
	new.font = font or love.graphics.getFont()
	new.defaultOnHover = function() end
	new.defaultOffHover = function() end
	new.defaultNotHover = function() end
	
	new.keys = {}
	new.mouse = {}
	new.previouslySelected = nil
	new.selected = nil
	new._isDefaultMouseEnabled = true
	new._isDefaultKeyboardEnabled = true
	new._isMouseEnabled = true
	new._isKeyboardEnabled = false
	
	new.buttons = {}
	local workingY = y
	for index = 1, #texts do
		local temp = Button.new( texts[index], new.x, workingY, new.font )
		
		new.buttons[index] = temp
		workingY = workingY + temp.height + new.lineSeparation
	end
	
	return new
end

function Menu.draw( self )
	if self.previouslySelected then self.buttons[self.previouslySelected].isHovering = false end
	if self.selected then self.buttons[self.selected].isHovering = true end
	self.previouslySelected = self.selected
	for index, aspect in ipairs( self.buttons ) do
		aspect:draw()
	end
end

function Menu.update( self, dt )
	local x, y = love.mouse.getX(), love.mouse.getY()
	if hasMouseMoved( self, x, y ) and self._isDefaultMouseEnabled then 
		self:setMouseEnabled( true )
		self:setKeyboardEnabled( false ) 
	end
	self.oldX, self.oldY = x, y
	
	local selected
	for index, aspect in ipairs( self.buttons ) do
		if self._isMouseEnabled then
			if Globals.boudingBox( x, y, aspect.x, aspect.y, aspect.width, aspect.height ) then
				selected = index
			end
		end
		aspect:update( dt )
	end
	if not self._isKeyboardEnabled then self.selected = selected end
end

-- line Separation
function Menu.setlineSeparation( self, separation ) 
	self.lineSeparation = separation
	
	local workingY = self:getY()
	for _, aspect in ipairs( self.buttons ) do
		aspect:setY( workingY )
		workingY = workingY + aspect.height + self.lineSeparation
	end
	
	return self 
end
function Menu.getlineSeparation( self ) return self.lineSeparation end
-- font
function Menu.setFont( self, font )
	self.font = font
	
	for _, aspect in ipairs( self.buttons ) do
		aspect:setFont( font )
	end
	
	return self
end
function Menu.getFont( self ) return self.font end
-- default On Hover
function Menu.setDefaultOnHover( self, func )
	for _, aspect in ipairs( self.buttons ) do
		aspect:setOnHover( func )
	end
	self.defaultOnHover = func
	return self
end
function Menu.getDefaultOnHover( self ) return self.defaultOnHover end
-- default Off Hover
function Menu.setDefaultOffHover( self, func ) 
	for _, aspect in ipairs( self.buttons ) do
		aspect:setOffHover( func )
	end
	self.defaultOffHover = func
	return self
end
function Menu.getDefaultOffHover( self ) return self.defaultOffHover end
-- default Not Hover
function Menu.setDefaultNotHover( self, func ) 
	for _, aspect in ipairs( self.buttons ) do
		aspect:setNotHover( func )
	end
	self.defaultNotHover = func
	return self
end
function Menu.getDefaultNotHover( self ) return self.defaultNotHover end
-- selected
function Menu.setSelected( self, index ) self.selected = index; return self end
function Menu.getSelected( self ) return self.selected end
-- default mouse Enabled
function Menu.setDefaultMouseEnabled( self, enabled ) 
	for _, aspect in ipairs( self.buttons ) do
		aspect:setMouseEnabled( enabled )
	end
	self._isDefaultMouseEnabled = enabled
	
	self._isDefaultKeyboardEnabled = not enabled or self._isDefaultKeyboardEnabled
	self._isKeyboardEnabled = not enabled or ( self._isDefaultKeyboardEnabled or self.isKeyboardEnabled )
	
	return self 
end
function Menu.isDefaultMouseEnabled( self ) return self._isDefaultMouseEnabled end
-- default Keyboard Enabled
function Menu.setDefaultKeyboardEnabled( self, enabled ) 
	for _, aspect in ipairs( self.buttons ) do
		aspect:setKeyboardEnabled( enabled )
	end
	self._isDefaultKeyboardEnabled = enabled
	
	self._isDefaultMouseEnabled = not enabled or self._isDefaultMouseEnabled
	self._isMouseEnabled = not enabled or ( self._isDefaultMouseEnabled or self._isMouseEnabled )
	
	return self 
end
function Menu.isDefaultKeyboardEnabled( self ) return self._isDefaultKeyboardEnabled end
-- mouse Enabled
function Menu.setMouseEnabled( self, enabled ) 
	for _, aspect in ipairs( self.buttons ) do
		aspect:setMouseEnabled( enabled )
	end
	self._isMouseEnabled = enabled
	
	return self 
end
function Menu.isMouseEnabled( self ) return self._isMouseEnabled end
-- Keyboard enabled
function Menu.setKeyboardEnabled( self, enabled ) 
	for _, aspect in ipairs( self.buttons ) do
		aspect:setKeyboardEnabled( enabled )
	end
	self._isKeyboardEnabled = enabled
	
	return self 
end
function Menu.IsKeyboardEnabled( self ) return self._isKeyboardEnabled end

-- Center
function Menu.CenterX( self )
	for _, aspect in ipairs( self.buttons ) do
		aspect:CenterX()
	end
	return self
end
function Menu.CenterY( self )
	local height = 0
	for index = 1, #self.buttons do
		local aspect = self.buttons[index]
		height = height + aspect.height + self.lineSeparation
	end
	local OriginY = ( Globals.Screenheight - height ) / 2
	local workingY = OriginY
	for _, aspect in ipairs( self.buttons ) do
		aspect:setY( workingY )
		workingY = workingY + aspect.height + self.lineSeparation
	end
	return self
end
function Menu.Center( self )
	self:CenterX()
	self:CenterY()
	return self
end

-- mouse Pressed
function Menu.mousePressed( self, x, y, b ) 
	if self._isDefaultMouseEnabled then self:setMouseEnabled( true ); self:setKeyboardEnabled( false ) end
	local func = self.mouse[b] 
	if func and self._isMouseEnabled then
		func( self, 'OnPress', x, y )
	end
end
-- mouse Released
function Menu.mouseReleased( self, x, y, b )
	local func = self.mouse[b] 
	if func and self._isMouseEnabled then
		func( self, 'OnRelease', x, y )
	end
end
-- Key Pressed
function Menu.keyPressed( self, key, isRepeat ) 
	if self._isDefaultKeyboardEnabled then self:setKeyboardEnabled( true ); self:setMouseEnabled( false ) end
	local func = self.keys[key]
	if func and self._isKeyboardEnabled then
		func( self, 'OnPress', key, isRepeat )
	end
end
-- Key Released
function Menu.keyReleased( self, key, isRepeat ) 
	local func = self.keys[Key] 
	if func and self._isKeyboardEnabled then
		func( self, 'OnRelease', key, isRepeat )
	end
end
-- Bind buttons
function Menu.bindButtonOnSelect( self, index, func )
	self.buttons[index]:setOnSelect( func )
	return self
end
function Menu.bindButtonOffSelect( self, index, func )
	self.buttons[index]:setOffSelect( func )
	return self
end

return Menu