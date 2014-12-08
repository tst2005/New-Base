local Animation = {}
Animation.__index = Animation

local Timer = require 'Utilities.Timer'

local function changeIndex( self, iterator )
	iterator = iterator or 1
	self.index = self.index + iterator
	
	if self.delays[self.index] then
		self:reload()
	else
		if self.looping then
			self.timesRepeated = self.timesRepeated + 1
			self.totalElapsedTime = 0
			self.index = 1
			self:reload()
		end
		self.onComplete( self.timesRepeated )
	end
end

local function checkForQuads( images, quad )
	for index = 1, #images do
		local type = images[index]:type()
		assert( quad and type, 'Animation Error: quad-images passed with no quad reference!' )
	end
end

function Animation.new( images, delays, quad ) 
	local New = { 
		images = images, 
		delays = delays, 
		length = #images, 
		index = 1, 
		looping = false, 
		quad = quad or nil, 
		active = true, 
		image = images[1], 
		totalElapsedTime = 0, 	-- NOTE: Resets on-loop.
		entireTime = 0, 
		onComplete = function() end, 
		timesRepeated = 0, 
	}
	
	New.timer = Timer.after( New.delays[New.index], changeIndex, New )
	checkForQuads( New.images, New.quad )

	setmetatable( New, Animation )
	return New
end

function Animation.reload( self )
	self.timer = Timer.after( self.delays[self.index], changeIndex, self )
	self.image = self.images[self.index]
end

function Animation.update( self, dt )
	if self.active then
		self.totalElapsedTime = self.totalElapsedTime + dt
		self.entireTime = self.entireTime + dt
		self.timer:update( dt )
	end
end

function Animation.draw( self, x, y, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY )
	if self.active and self.image then
		local type = self.image:type()
		
		if type == 'Image' then
			love.graphics.draw( self.image, x, y, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY )
		elseif type == 'Quad' then
			love.graphics.draw( self.quad, self.image, x, y, rotation, scaleX, scaleY, offsetX, offsetY, shearingX, shearingY )
		end
	end
end

-- images
function Animation.setImages( self, images ) self.images = images; return self end
function Animation.getImages( self ) return self.images end
-- delays
function Animation.setDelays( self, delays ) self.delays = delays; return self end
function Animation.getDelays( self ) return self.delays end
-- length
function Animation.setLength( self, length ) self.length = length; return self end
function Animation.getlength( self ) return self.length end
-- index
function Animation.setIndex( self, index ) self.index = index; return self end
function Animation.getIndex( self ) return self.index end
-- looping
function Animation.setLooping( self, looping ) if looping == nil then self.looping = true else self.looping = looping end; return self end
function Animation.isLooping( self ) return self.looping end
-- quad
function Animation.setQuadImage( self, quadImage ) self.quad = quadImage; return self end
function Animation.getQuadImage( self ) return self.quadImage end
-- active
function Animation.setActive( self, active ) self.active = active; return self end
function Animation.getActive( self ) return self.active end
-- Timer
function Animation.setTimer( self, Timer ) self.Timer = Timer; return self end
function Animation.getTimer( self ) return self.Timer end
-- image
function Animation.setCurrentImage( self, curretImage ) self.image = curretImage; return self end
function Animation.getCurrentImage( self ) return self.image end
-- Total Elapsed time
function Animation.setTotalElapsedtime( self, time ) self.totalElapsedtime = time; return self end
function Animation.getTotalElapsedtime( self ) return self.totalElapsedtime end
-- Entire time
function Animation.setentireTime( self, time ) self.entireTime = time; return self end
function Animation.getentireTime( self ) return self.entireTime end
-- On Complete
function Animation.setOnComplete( self, f ) self.onComplete = f end
function Animation.getOnComplete( self ) return self.onComplete end

return Animation