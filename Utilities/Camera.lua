local Base = require 'Source.Entities.Base'
local Globals = require 'Utilities.Globals'
local Tween = require 'Utilities.Tween'
local MLib = require 'Utilities.Third Party.mlib'
local Camera = Base:Extend()
local OldNew = Base.New

local function RotateRectangle( x, y, Width, Height, Rotation, OffsetX, OffsetY )
	local CenterX, CenterY = x + Width / 2, y + Height / 2
	local Cos = math.cos( Rotation )
	local Sin = math.sin( Rotation )
	local New = {
		( x - CenterX ) * Cos - ( y - CenterY ) * Sin + CenterX - OffsetX, ( x - CenterX ) * Sin + ( y - CenterY ) * Cos + CenterY - OffsetY, 
		( x + Width - CenterX ) * Cos - ( y - CenterY ) * Sin + CenterX - OffsetX, ( x + Width - CenterX ) * Sin + ( y - CenterY ) * Cos + CenterY - OffsetY, 
		( x + Width - CenterX ) * Cos - ( y + Height - CenterY ) * Sin + CenterX - OffsetX, ( x + Width - CenterX ) * Sin + ( y + Height - CenterY ) * Cos + CenterY - OffsetY, 
		( x - CenterX ) * Cos - ( y + Height - CenterY ) * Sin + CenterX - OffsetX, ( x - CenterX ) * Sin + ( y + Height - CenterY ) * Cos + CenterY - OffsetY, 
	}
	return New
end

local function Check( Camera, Object )
	local SegmentInside = MLib.Polygon.IsLineSegmentInside( Object[#Object - 1], Object[#Object], Object[1], Object[2], Camera )
	for Index = 1, #Object - 2, 2 do
		SegmentInside = SegmentInside or MLib.Polygon.IsLineSegmentInside( Object[Index], Object[Index + 1], Object[Index + 2], Object[Index + 3], Camera )
	end
	
	return not not MLib.Polygon.PolygonIntersects( Camera, Object ) or SegmentInside
end

function Camera.New( Settings )
	local New = {
		x = Settings.x, 
		y = Settings.y, -- x and y are actually the center of the camera. 
		Rotation = Settings.Rotation or 0, 
		ScaleX = Settings.ScaleX or 1, 
		ScaleY = Settings.ScaleY or 1, 
		Tween = Tween.Easing[Settings.Tween] or Tween.Easing['Linear'], 
		Width = Settings.Width or Globals.ScreenWidth, 
		Height = Settings.Height or Globals.ScreenHeight, 
		Input = Settings.Input or true, -- Allows you to control whether or not the player can move the camera. 
	}
	New.TargetX = Settings.TargetX or New.x
	New.TargetY = Settings.TargetY or New.y
	
	New.__index = New
	setmetatable( New, Camera )
	
	return New
end

function Camera.InsideView( Self, Object )
	local RotatedCamera = RotateRectangle( Self.x, Self.y, Self.Width, Self.Height, Self.Rotation, Self.Width / 2, Self.Height / 2 )
	local RotatedObject = RotateRectangle( Object.x, Object.y, Object.Width, Object.Height, Object.Rotation, Object.OffsetX, Object.OffsetY )
	
	return Check( RotatedCamera, RotatedObject )
end

return Camera