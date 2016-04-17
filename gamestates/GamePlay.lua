local StateManager = require ("include.StateManager")
require ("include.Common")

local GamePlay = {
	self = nil,
	Image = nil,
	isPaused = false,
	Level = {},
	Player = {},
	Entities = {},
	enabled = false
}


--local Input = require("include.Input")
--local Audio = require("include.Audio")
--local Level = require("include.Level")
--local Entity = require("include.Entity")

local Level = require ("include.Level")
local Player = require ( "include.Player" )
local Entities = {}

local timer = 0.05

function GamePlay:new(o)
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

function GamePlay:load()
	print("Polygonology Play Loading...")
	self.Player = Player:new()
	self.Player:load()

	self.Level = Level:new()
	self.Level:load()
end

function GamePlay:unload()

end

function GamePlay:update(dt)
	
	self.Player:update(dt)
	--[[
	for i=1,#Entities do
		Entities[i]:update(dt)
	end
	]]
	self.Level:update(dt)
	
	--Camera:update(dt)
	timer = timer - dt
	if timer < 0 then
		self.Player:AddPoint()
		timer = 0.05
	end

end


function GamePlay:draw()
	--love.graphics.print('Polygonology', 400, 300)
	--love.graphics.draw( self.Image, 20, 20, 0, 1, 1, 0, 0, 0, 0 )
	self.Player:draw()
	self.Level:draw()
end

function GamePlay:ChangeState()
	return false
end
function GamePlay:getNextState()
	-- find cursor collisions with buttons
end

function GamePlay:mousepressed(x,y,button,istouch)
	print("GamePlay:mousepressed() ---> " .. x .. ","..y..","..button.."\n")
end
function GamePlay:mousereleased(x,y,button,istouch)
	print("GamePlay:mousereleased() ---> " .. x .. ","..y..","..button.."\n")
end

function GamePlay:keypressed( key, scancode, isrepeat )
	print("GamePlay:keypressed() ---> " .. key )

	if key == "escape" then
		--Throw State Change to Credits
		StateManager:SwitchTo("Titlescreen")
	end

	if key == "w" or key == "up" then
		Player:Accelerate()
	end
	if key == "s" or key == "down" then
		Player:Decelerate()
	end
	if key == "a" or key == "left" then
		Player:RotateLeft()
	end
	if key == "d" or key == "right" then
		Player:RotateRight()
	end
	if key == "space" then
		Player:Deflect()
	end
	if key == "left shift" then
		Player:Boost()
	end


end

function GamePlay:keyreleased( key )
	print("GamePlay:keyreleased() ---> " .. key )
end

function GamePlay:resize(w,h)

	cx = w / 2
	cy = h / 2

end


return GamePlay
