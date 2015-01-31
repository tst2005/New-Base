-- Libraries
local lurker = require 'Utilities.lurker.lurker'
Input = require 'Utilities.thomas.Input'
Car = require 'Source.Car'
Car:setState( 'Running' )

function love.load()
	input = Input()
	input:bind( 'escape', love.event.quit )
	
	Cars = {
		Honda = Car( 'Honda' ), 
		Chevy = Car( 'Chevy' ), 
		Ford = Car( 'Ford' ), 
	}
	
	print()
	local function printCars()
		for _, v in pairs( Cars ) do
			v:speak()
		end
		print'---'
	end
	
	Cars.Honda:setState( 'Broken' )
	printCars()
	
	Cars.Honda:popState()
	printCars()
	Cars.Honda:popState()
	printCars()
	for _, v in pairs( Cars ) do
		v:crash()
	end
end

function love.update( dt )		
	lurker.update()
	input:update( dt ) 
end

function love.draw()
end

function love.keypressed( key, isRepeat )
	input:keypressed( key )
end

function love.keyreleased( key, isRepeat )
	input:keyreleased( key )
end

function love.mousepressed( x, y, button )
	input:mousepressed( button )
end

function love.mousereleased( x, y, button )
	input:mousereleased( button )
end

function love.gamepadpressed( joystick, button )
	input:gamepadpressed( joystick, button )
end

function love.gamepadreleased( joystick, button )
	input:gamepadreleased( joystick, button )
end

function love.gamepadaxis( joystick, axis, value )
	input:gamepadaxis( joystick, axis, value )
end

function love.quit()
end
