local Base = require 'Source.Entities.Base'
local Button = require 'Utilities.Button'
local Globals = require 'Utilities.Globals'
local Menu = Button:Extend()
local OldNew = Base.New

local function MouseMove( Self, x, y )
	if x ~= Self.OldX or y ~= Self.OldY then return true end
	return false
end

function Menu.New( x, y, LineSeparation, Font, ... )
	local New = Menu:Extend()
	
	local Texts = { ... }
	
	New.x = x
	New.y = y
	New.OldMouseX, New.OldMouseY = love.mouse.getX(), love.mouse.getY()
	
	New.LineSeparation = LineSeparation or 2
	New.Font = Font or love.graphics.getFont()
	New.DefaultOnHover = function() end
	New.DefaultOffHover = function() end
	New.DefaultNotHover = function() end
	
	New.Keys = {}
	New.Mouse = {}
	New.PreviouslySelected = nil
	New.Selected = nil
	New.DefaultMouseEnabled = true
	New.DefaultKeyboardEnabled = true
	New.MouseEnabled = true
	New.KeyboardEnabled = false
	
	New.Buttons = {}
	local WorkingY = y
	for Index = 1, #Texts do
		local Temp = Button.New( Texts[Index], New.x, WorkingY, New.Font )
		
		New.Buttons[Index] = Temp
		WorkingY = WorkingY + Temp.Height + New.LineSeparation
	end
	
	return New
end

function Menu.Draw( Self )
	if Self.PreviouslySelected then Self.Buttons[Self.PreviouslySelected].IsHovering = false end
	if Self.Selected then Self.Buttons[Self.Selected].IsHovering = true end
	Self.PreviouslySelected = Self.Selected
	for Index, Aspect in ipairs( Self.Buttons ) do
		Aspect:Draw()
	end
end

function Menu.Update( Self, dt )
	local x, y = love.mouse.getX(), love.mouse.getY()
	if MouseMove( Self, x, y ) and Self.DefaultMouseEnabled then Self:SetMouseEnabled( true ); Self:SetKeyboardEnabled( false ) end
	Self.OldX, Self.OldY = x, y
	
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:Update( dt )
	end
end

-- Line Separation
function Menu.SetLineSeparation( Self, Separation ) 
	Self.LineSeparation = Separation
	
	local WorkingY = Self:GetY()
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetY( WorkingY )
		WorkingY = WorkingY + Aspect.Height + Self.LineSeparation
	end
	
	return Self 
end
function Menu.GetLineSeparation( Self ) return Self.LineSeparation end
-- Font
function Menu.SetFont( Self, Font )
	Self.Font = Font
	
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetFont( Font )
	end
	
	return Self
end
function Menu.GetFont( Self ) return Self.Font end
-- Default On Hover
function Menu.SetDefaultOnHover( Self, Function )
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetOnHover( Function )
	end
	Self.DefaultOnHover = Function
	return Self
end
function Menu.GetDefaultOnHover( Self ) return Self.DefaultOnHover end
-- Default Off Hover
function Menu.SetDefaultOffHover( Self, Function ) 
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetOffHover( Function )
	end
	Self.DefaultOffHover = Function
	return Self
end
function Menu.GetDefaultOffHover( Self ) return Self.DefaultOffHover end
-- Default Not Hover
function Menu.SetDefaultNotHover( Self, Function ) 
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetNotHover( Function )
	end
	Self.DefaultNotHover = Function
	return Self
end
function Menu.GetDefaultNotHover( Self ) return Self.DefaultNotHover end
-- Selected
function Menu.SetSelected( Self, Index ) Self.Selected = Index; return Self end
function Menu.GetSelected( Self ) return Self.Selected end
-- Default Mouse Enabled
function Menu.SetDefaultMouseEnabled( Self, Enabled ) 
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetMouseEnabled( Enabled )
	end
	Self.DefaultMouseEnabled = Enabled
	
	Self.DefaultKeyboardEnabled = not Enabled or Self.DefaultKeyboardEnabled
	Self.KeyboardEnabled = not Enabled or ( Self.DefaultKeyboardEnabled or Self.KeyboardEnabled )
	
	return Self 
end
function Menu.IsMouseEnabled( Self ) return Self.MouseEnabled end
-- Default Keyboard Enabled
function Menu.SetDefaultKeyboardEnabled( Self, Enabled ) 
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetKeyboardEnabled( Enabled )
	end
	Self.DefaultKeyboardEnabled = Enabled
	
	Self.DefaultMouseEnabled = not Enabled or Self.DefaultMouseEnabled
	Self.MouseEnabled = not Enabled or ( Self.DefaultMouseEnabled or Self.MouseEnabled )
	
	return Self 
end
function Menu.IsKeyboardEnabled( Self ) return Self.KeyboardEnabled end
-- Mouse Enabled
function Menu.SetMouseEnabled( Self, Enabled ) 
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetMouseEnabled( Enabled )
	end
	Self.MouseEnabled = Enabled
	
	return Self 
end
function Menu.IsMouseEnabled( Self ) return Self.MouseEnabled end
-- Keyboard Enabled
function Menu.SetKeyboardEnabled( Self, Enabled ) 
	for _, Aspect in ipairs( Self.Buttons ) do
		Aspect:SetKeyboardEnabled( Enabled )
	end
	Self.KeyboardEnabled = Enabled
	
	return Self 
end
function Menu.IsKeyboardEnabled( Self ) return Self.KeyboardEnabled end

-- Mouse Pressed
function Menu.MousePressed( Self, x, y, b ) 
	if Self.DefaultMouseEnabled then Self:SetMouseEnabled( true ); Self:SetKeyboardEnabled( false ) end
	local Function = Self.Mouse[b] 
	if Function and Self.MouseEnabled then
		if Globals.BoundingBox( x, y, Self.x, Self.y, Self.Width, Self.Height ) then
			Function( Self, 'OnPress', x, y )
		end
	end
end
-- Mouse Released
function Menu.MouseReleased( Self, x, y, b )
	local Function = Self.Mouse[b] 
	if Function and Self.MouseEnabled then
		if Globals.BoundingBox( x, y, Self.x, Self.y, Self.Width, Self.Height ) then
			Function( Self, 'OnRelease', x, y )
		end
	end
end
-- Key Pressed
function Menu.KeyPressed( Self, Key, IsRepeat ) 
	if Self.DefaultKeyboardEnabled then Self:SetKeyboardEnabled( true ); Self:SetMouseEnabled( false ) end
	local Function = Self.Keys[Key]
	if Function and Self.KeyboardEnabled then
		Function( Self, 'OnPress', Key, IsRepeat )
	end
end
-- Key Released
function Menu.KeyReleased( Self, Key, IsRepeat ) 
	local Function = Self.Keys[Key] 
	if Function and Self.KeyboardEnabled then
		Function( Self, 'OnRelease', Key, IsRepeat )
	end
end

return Menu