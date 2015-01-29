local Class = require 'Utilities.classic.classic'
local State = require 'Utilities.Internal.State'

local Car = Class:extend( 'Car' )
Car:implement( State )

function Car:new( name ) 
	self.name = name
end

function Car:stop() print( 'Stopping the car!' ) end
function Car:speak() print( string.format( 'I am a car named "%s!"', self.name ) ) end
function Car:crash() print( 'This is an example of a fallback. Only the main class has this.' ) end

local Running = Car:addState( 'Running' )
function Running:speak() print( string.format( 'I am a running car named "%s!"', self.name ) ) end
function Running:stop() print( 'STOP STOP STOP!' ) end

local Broken = Car:addState( 'Broken' )
function Broken:speak() print( string.format( 'I am a broken car name "%s!" :(', self.name ) ) end
function Broken:stop() print( 'I am broken and therefore already stopped...' ) end


return Car