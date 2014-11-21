local Base = require 'Source.Entities.Base'
local Test = Base:Extend()
Test.States = {
	Idle = {
		Enter = function() print 'Test Enter- Idle' end, 
		Exit = function() print 'Test Exit- Idle' end, 
		Update = function() print 'Test Update- Idle' end, 
	}, 
	Moving = {
		Enter = function() print 'Test Enter- Moving' end, 
		Exit = function() print 'Test Exit- Moving' end, 
		Update = function( Self, dt ) 
			Self.x = Self.x + Self.vx * dt
			Self.y = Self.y + Self.vy * dt
			print 'Test Update- Moving' 
		end, 
	}, 
}

function Test.New( x, y )
	local New = Test:Extend()
	New.x, New.y = x, y
	New.StateStack = {}
	New.OldX, New.OldY = x, y
	New.vx, New.vy = 0, 0
	New.Oldvx, New.Oldvy = 0, 0
	
	New:SetState( Test.States.Idle )
	
	return New
end

function Test.Draw( Self )
	love.graphics.rectangle( 'fill', Self.x, Self.y, 32, 32 )
end

function Test.Update( Self, dt )
	if ( Self.vx == 0 and Self.vy == 0 ) and ( Self.Oldvx ~= Self.vx or Self.Oldvy ~= Self.vy ) then
		Self:SetState( Test.States.Idle )
	elseif Self.Oldvx ~= Self.vx or Self.Oldvy ~= Self.vy then
		Self:SetState( Test.States.Moving )
	end
	Self.OldX, Self.OldY = Self.x, Self.y
	Self.Oldvx, Self.Oldvy = Self.vx, Self.vy
	Self.State.Update( Self, dt )
end

function Test.KeyPress( Self, Key )
	if Key == Self.Key1 then Self.vx = Self.vx - 32 end
	if Key == Self.Key2 then Self.vx = Self.vx + 32 end
end

return Test