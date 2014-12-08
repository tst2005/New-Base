local tween = require 'Utilities.Third Party.tween'
local originalMeta = getmetatable( tween.new( 1, { 1 }, { 1 } ) )
local Tween = {}
Tween.__index = Tween
setmetatable( Tween, originalMeta )
Tween.easing = tween.easing

-- tween.lua functions
function Tween.new( time, subject, target, easing )
	local new = tween.new( time, subject, target, easing )
	new.__index = Tween
	setmetatable( new, Tween )
	return new
end

function Tween.update( self, dt )
	return self:update( dt )
end

function Tween.set( self, clock )
	return self:set( clock )
end

function Tween.reset( self )
	self:reset()
end

-- duration
function Tween.setDuration( self, duration ) self.duration = duration; return self end
function Tween.getDuration( self ) return self.duration end
-- Subject
function Tween.setSubject( self, t ) self.subject = t; return self end
function Tween.getSubject( self ) return self.subject end
-- Target
function Tween.setTarget( self, t ) self.target = t; return self end
function Tween.getTarget( self ) return self.target end
-- Easing
function Tween.setEasing( self, type ) self.easing = type; return self end
function Tween.getEasing( self ) return self.easing end
-- Initial
function Tween.setInitial( self, values ) self.initial = values; return self end
function Tween.getInitial( self ) return self.initial end
-- clock
function Tween.getTime( self ) return self.clock end

return Tween