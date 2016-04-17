local Credits = {
	self = nil,
	Image = nil,
	Name = nil,
	LD = nil,
	Music = nil,
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

function Credits:new(o)
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

function Credits:load()
	print("Polygonology Credits Loading...")
	self.Image = love.graphics.newImage( "assets/polygonology.png" )
	self.Name = love.graphics.newImage( "assets/jfoxdev.png" )
	self.LD = love.graphics.newImage( "assets/ld35.png" )
	ox = self.Image:getWidth()/2
	oy = self.Image:getHeight()/2

end

function Credits:unload()

end

function Credits:update(dt)
	-- find cursor collisions with buttons
end
function Credits:ChangeState()
	return false
end
function Credits:getNextState()
	-- find cursor collisions with buttons
end


function Credits:draw()
	--love.graphics.print('Polygonology', 400, 300)
	love.graphics.setColor( 0, 255, 0, 255 )
	love.graphics.draw( self.Image, cx - ox, 50, 0, 1, 1, 0, 0, 0, 0 )
	love.graphics.draw( 
			self.Name, 
			love.graphics.getWidth() - self.Name:getWidth(), 
			love.graphics.getHeight() - self.Name:getHeight(), 
			0, 1, 1, 0, 0, 0, 0 )
	love.graphics.draw( 
			self.LD, 
			0, 
			love.graphics.getHeight() - self.LD:getHeight(), 
			0, 1, 1, 0, 0, 0, 0 )

end


function Credits:mousepressed(x,y,button,istouch)
	print("Credits:mousepressed() ---> " .. x .. ","..y..","..button.."\n")
end
function Credits:mousereleased(x,y,button,istouch)
	print("Credits:mousereleased() ---> " .. x .. ","..y..","..button.."\n")
end

function Credits:keypressed( key, scancode, isrepeat )
	print("Credits:keypressed() ---> " .. key )
	

	if key == "escape" then
		--Throw State Change to Credits
		--love.quit()
	end
	
	love.event.quit()

end

function Credits:keyreleased( key )
	print("Credits:keyreleased() ---> " .. key )
end

function Credits:resize(w,h)

	cx = w / 2
	cy = h / 2

end


return Credits
