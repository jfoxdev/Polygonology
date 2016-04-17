local StateManager = require ("include.StateManager")

local Scores = {
	self = nil,
	Image = nil,
	ClickNoise = nil,
	enabled = false
}

--local Input = require("include.Input")
--local Audio = require("include.Audio")
--local Level = require("include.Level")
--local Player = require("include.Player")
--local Entity = require("include.Entity")

local cx = love.graphics.getWidth() / 2
local cy = love.graphics.getHeight() / 2
local offx = 0
local offy = 0

require ("include.Common")

function Scores:new(o)
	if o == nil then 
		o = {}
	else
		o = DeepCopy(o)
	end
	
	--o = o or {}   -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function Scores:load()
	print("Polygonology Scores Loading...")
	self.Image = love.graphics.newImage( "assets/scores.png" )
	ox = self.Image:getWidth()/2
	oy = self.Image:getHeight()/2

end

function Scores:unload()

end

function Scores:update(dt)
	-- find cursor collisions with buttons
end
function Scores:ChangeState()
	return false
end
function Scores:getNextState()
	-- find cursor collisions with buttons
end


function Scores:draw()
	--love.graphics.print('Polygonology', 400, 300)
	love.graphics.setColor( 0, 255, 0, 255 )
	love.graphics.draw( self.Image, cx - ox, 50, 0, 1, 1, 0, 0, 0, 0 )


end


function Scores:mousepressed(x,y,button,istouch)
	print("Scores:mousepressed() ---> " .. x .. ","..y..","..button.."\n")
end
function Scores:mousereleased(x,y,button,istouch)
	print("Scores:mousereleased() ---> " .. x .. ","..y..","..button.."\n")
end

function Scores:keypressed( key, scancode, isrepeat )
	print("Scores:keypressed() ---> " .. key )
	

	if key == "escape" then
		StateManager:SwitchTo("Titlescreen")
	end

end

function Scores:keyreleased( key )
	print("Scores:keyreleased() ---> " .. key )
end

function Scores:resize(w,h)

	cx = w / 2
	cy = h / 2

end


return Scores
