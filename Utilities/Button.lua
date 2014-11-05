local Base = require 'Source.Entities.Base'
local Button = Base:Extend()
local Globals = require 'Utilities.Globals'
local OldNew = Button.New

function Button.New( Text, x, y, Font )
	local New = OldNew( x, y )
	New.__index = New
	setmetatable( New, Button )
	
	New.Font = Font or love.graphics.getFont()
	New.Text = Text
	New.Width, New.Height = New.Font:getWidth( New.Text ), New.Font:getHeight( New.Text )
	New.OnSelect = function() end
	New.OnHover = function() end
	New.OffHover = function() end
	New.NotHover = function() end
	New.Keys = {}
	New.Mouse = {}
	New.Color = { 255, 255, 255, 255 }
	New.MouseEnabled = true
	New.KeyboardEnabled = true
	
	New.WidthSet = false
	New.HeightSet = false
	
	New.IsHovering = false
	New.WasHovering = false
	
	return New
end

function Button.Draw( Self )
	love.graphics.setColor( Self.Color )
	love.graphics.setFont( Self.Font )
	love.graphics.print( Self.Text, unpack{ Self:GetDrawingValues() } )
end

function Button.Update( Self, dt )
	if Self.MouseEnabled then
		local MouseX, MouseY = love.mouse.getX(), love.mouse.getY()
		if Globals.BoundingBox( MouseX, MouseY, Self.x, Self.y, Self.Width, Self.Height ) then
			Self.IsHovering = true
		else 
			Self.IsHovering = false
		end
	end
	if Self.IsHovering then
		Self.WasHovering = true
		Self:OnHover()
	elseif not Self.IsHovering and not Self.WasHovering then
		Self:NotHover()
	elseif Self.WasHovering and not Self.IsHovering then
		local Active = Self:OffHover()
		if not Active then
			Self.WasHovering = false
		end
	end
end

-- Font
function Button.SetFont( Self, Font )
	Self.Font = Font
	if not Self.WidthSet then Self:SetWidth( Self.Font:getWidth( Self.Text ) ) end
	if not Self.HeightSet then Self:SetHeight( Self.Font:getHeight( Self.Text ) ) end
	return Self
end
function Button.GetFont( Self ) return Self.Font end
-- Text
function Button.SetText( Self, Text )
	Self.Text = Text
	if not Self.WidthSet then Self:SetWidth( Self.Font:getWidth( Self.Text ) ) end
	if not Self.GetWidth then Self:SetHeight( Self.Font:getHeight( Self.Text ) ) end
	return Self
end
function Button.GetText( Self ) return Self.Text end
-- Width
function Button.SetWidth( Self, Width ) Self.Width, Self.WidthSet = Width, true; return Self end
function Button.GetWidth( Self ) return Self.Width end
-- Height
function Button.SetHeight( Self, Height ) Self.Height, Self.HeightSet = Height, true; return Self end
function Button.GetHeight( Self ) return Self.Height end
-- Dimensions
function Button.SetDimensions( Self, Width, Height ) Self.Width, Self.Height, Self.WidthSet, Self.HeightSet = Width, Height, true, true; return Self end
function Button.GetDimensions( Self ) return Self.Width, Self.Height end
-- On Select
function Button.SetOnSelect( Self, Function ) Self.OnSelect = Function; return Self end
function Button.GetOnSelect( Self ) return Self.OnSelect end
-- On Hover
function Button.SetOnHover( Self, Function ) Self.OnHover = Function; return Self end
function Button.GetOnHover( Self ) return Self.OnHover end
-- Off Hover
function Button.SetOffHover( Self, Function ) Self.OffHover = Function; return Self end
function Button.GetOffHover( Self ) return Self.OffHover end
-- Not Hover
function Button.SetNotHover( Self, Function ) Self.NotHover = Function; return Self end
function Button.GetNotHover( Self ) return Self.NotHover end
-- Bind Keys
function Button.BindKey( Self, Key, Function ) Self.Keys[Key] = Function; return Self end
function Button.UnbindKey( Self, Key ) Self.Keys[Key] = nil; return Self end
function Button.GetKeyBinding( Self, Key ) return Self.Keys[Key] end
-- Bind Mouse
function Button.BindMouse( Self, Button, Function ) Self.Mouse[Button] = Function; return Self end
function Button.UnbindMouse( Self, Button ) Self.Mouse[Button] = nil; return Self end
function Button.GetMouseBinding( Self, Button ) return Self.Mouse[Button] end
-- MouseEnabled
function Button.SetMouseEnabled( Self, Enabled ) Self.MouseEnabled = Enabled; return Self end
function Button.IsMouseEnabled( Self ) return Self.MouseEnabled end
-- KeyboardEnabled
function Button.SetKeyboardEnabled( Self, Enabled ) Self.KeyboardEnabled = Enabled; return Self end
function Button.IsKeyboardEnabled( Self ) return Self.KeyboardEnabled end
-- Mouse Select
function Button.SetOnSelect( Self, Function ) Self.OnSelect = Function; return Self end
function Button.GetOnSelect( Self ) return Self.OnSelect end

-- Mouse Pressed
function Button.MousePressed( Self, x, y, Button ) 
	local Function = Self.Mouse[Button] 
	if Function and Self.MouseEnabled then
		if Globals.BoundingBox( x, y, Self.x, Self.y, Self.Width, Self.Height ) then
			Function( Self, 'OnPress', x, y )
		end
	end
end
-- Mouse Released
function Button.MouseReleased( Self, x, y, Button ) 
	local Function = Self.Mouse[Button] 
	if Function and Self.MouseEnabled then
		if Globals.BoundingBox( x, y, Self.x, Self.y, Self.Width, Self.Height ) then
			Function( Self, 'OnRelease', x, y )
		end
	end
end
-- Key Pressed
function Button.KeyPressed( Self, Key, IsRepeat ) 
	local Function = Self.Keys[Key]
	if Function and Self.KeyboardEnabled then
		Function( Self, 'OnPress', Key, IsRepeat )
	end
end
-- Key Released
function Button.KeyReleased( Self, Key, IsRepeat ) 
	local Function = Self.Keys[Key] 
	if Function and Self.KeyboardEnabled then
		Function( Self, 'OnRelease', Key, IsRepeat )
	end
end

return Button