local StateManager = require ("include.StateManager")
local Highscores = require ("include.Highscores")
require ("include.Common")

local GamePlay = {
	self = nil,
	Image = nil,
	isPaused = false,
	Font = {},
	Level = {},
	Player = {},
	Entities = {},
	enabled = false
}


--local Input = require("include.Input")
--local Audio = require("include.Audio")
--local Level = require("include.Level")
--local Entity = require("include.Entity")

local Camera = require ("include.Camera")
local Level = require ("include.Level")
local Player = require ( "include.Player" )
local Entities = {}

local TimerMax = 3
local Timer = 1

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
	
	self.Font = love.graphics.newFont( "assets/Hack.ttf", 16 )
	love.graphics.setFont(self.Font);

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
	Timer = Timer - dt
	if Timer < 0 then
		self.Player:AddPoint()
		Timer = math.random(0,TimerMax)
	end
	

end


function GamePlay:draw()
	
	Camera:set()
	

	self.Player:draw()
	--[[
	Camera:setFocus(
		self.Player.position.x, 
		self.Player.position.y
	)
	]]
	Camera:setPosition(0,0)
	self.Level:draw()

	love.graphics.setColor(50,255,50,220)
	love.graphics.print("Level: "..self.Player.level, 10, 10);
	love.graphics.print("Score: "..self.Player.score, 10, 30);
	love.graphics.print("Mass: "..self.Player.mass, 10, 50);
	love.graphics.print("Segments: "..self.Player.Polygon.segments, 10, 70);

	Camera:unset()
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

	if key == "f1" then
		print("Saving score...")
		Highscores:save("Player Name", self.Player.score, os.time())
	end

	if key == "w" or key == "up" then
		self.Player:Accelerate()
	end
	if key == "s" or key == "down" then
		self.Player:Decelerate()
	end
	if key == "a" or key == "left" then
		self.Player:RotateLeft()
	end
	if key == "d" or key == "right" then
		self.Player:RotateRight()
	end
	if key == "space" then
		--Player:Deflect()
		self.Level.Polymitters[1]:Spawn(3, 100,100)
	end
	if key == "left shift" then
		self.Player:Boost()
	end


end

function GamePlay:keyreleased( key )
	print("GamePlay:keyreleased() ---> " .. key )
end

function GamePlay:resize(w,h)

	cx = w / 2
	cy = h / 2

	Level:resize(w,h)
end


return GamePlay
