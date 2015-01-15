local Class = require 'Utilities.classic.classic'
local State = require 'Utilities.Internal.State'

local Car = Class:extend( 'Car' )
Car:implement( State )

local Running = Car:addState( 'Running' )

function Car:new( name ) 
	self.name = name
	self:setState( Running )
	return self 
end

function Car:stop() print( 'Stopping the car!' ) end
function Car:speak() print( string.format( 'I am a car named "%s"!', self.name ) ) end

function Running:speak() print( string.format( 'I am a running car named "%s"!', self.name ) ) end
function Running:stop() print( 'STOP STOP STOP!' ) end

return Car