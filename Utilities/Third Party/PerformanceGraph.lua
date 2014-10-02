-- Made by: "Jasoco" http://love2d.org/forums/memberlist.php?mode=viewprofile&u=594
-- From Post: http://love2d.org/forums/viewtopic.php?f=4&t=78526&start=10#p172077

local win = love.window
local lgr = love.graphics
local tmr = love.timer

local performanceGraph = {}
performanceGraph.enabled = false

local performanceGraphUpdateTime = 0
local performanceGraphDrawTime = 0
local performanceGraphTickPos = 0
local performanceGraphTickScale = 10000
local performanceGraphWidth = 1000
local performanceGraphScale = win.getPixelScale()
local performanceGraphCanvas = lgr.newCanvas(performanceGraphWidth, 800)
performanceGraphCanvas:setFilter("nearest")

local _performanceGraphTime = 0

local function performanceGraphReset()
   local _s = 1 / 60
   performanceGraphTickPos = 0
   performanceGraphCanvas:clear(0,0,0,0)
   lgr.setColor(0,0,0,100)
   lgr.rectangle("fill", 0, 0, performanceGraphWidth, _s * performanceGraphTickScale)
   lgr.setColor(255,255,255)
   lgr.line(0, _s * performanceGraphTickScale, performanceGraphWidth, _s * performanceGraphTickScale)
end

-- Call this at the top of love.update before anything else
function performanceGraph:preUpdate()
   if not self.enabled then return false end
   _performanceGraphTime = tmr.getTime()
end

-- Call this at the bottom of love.update after everything else
function performanceGraph:postUpdate()
   if not self.enabled then return false end
   performanceGraphUpdateTime = tmr.getTime() - _performanceGraphTime
end

-- Call this at the top of love.draw before anything else
function performanceGraph:preDraw()
   if not self.enabled then return false end
   _performanceGraphTime = tmr.getTime()
end

-- Call this at the bottom of love.draw after everything else
function performanceGraph:postDraw()
   if not self.enabled then return false end
   performanceGraphDrawTime = tmr.getTime() - _performanceGraphTime

   lgr.setCanvas(performanceGraphCanvas)

   if performanceGraphTickPos == 0 then performanceGraphReset() end
   lgr.setColor(0,255,0)
   lgr.rectangle("fill", performanceGraphTickPos, 0, 1, performanceGraphUpdateTime * performanceGraphTickScale)
   lgr.setColor(0,0,255)
   lgr.rectangle("fill", performanceGraphTickPos, performanceGraphUpdateTime * performanceGraphTickScale, 1, performanceGraphDrawTime * performanceGraphTickScale)
   performanceGraphTickPos = performanceGraphTickPos + 1
   if performanceGraphTickPos >= performanceGraphWidth then performanceGraphTickPos = 0 end
   lgr.setCanvas()

   lgr.setColor(255,255,255)
   lgr.draw(performanceGraphCanvas, 0, lgr.getHeight(), 0, performanceGraphScale, -performanceGraphScale)
end

function performanceGraph:toggle()
   performanceGraphReset()
   self.enabled = not self.enabled
end

return performanceGraph