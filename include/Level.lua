require ( "include.Common" )
local Polygonoid = require ( "include.Polygonoid" )

local Level = {
	id = "",
	name = "Level",
	score = 0,
	progression = 0.0,

	position = { x = 0, y = 0 },
	dimensions = { w = 1, h = 1 },
	rotation = 0,
	
	World = {},
	Background = { r=0.0,g=0.0,b=0.0,a=1.0 },
	Entities = {},
	Polymitters = {},
	Attractors = {},
	Deflectors = {},
}

local timer = 2.0

function Level:new(o)
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


function Level:load(p)
	self.World = love.physics.newWorld( 0, 0, true)
    self.World:setCallbacks(beginContact, endContact, preSolve, postSolve)
	love.physics.setMeter(32) -- set 32 pixels/meter
	
	--[[
	self.Polymitters[1] = Polymitter:new()
	self.Polymitters[1]:load(0,0)
	self.Polymitters[2] = Polymitter:new()
	self.Polymitters[2]:load(0,love.graphics.getHeight())
	self.Polymitters[3] = Polymitter:new()
	self.Polymitters[3]:load(love.graphics.getWidth(),love.graphics.getHeight())
	self.Polymitters[4] = Polymitter:new()
	self.Polymitters[4]:load(love.graphics.getWidth(),0)
	]]

	for i=1,20 do
		self.Entities[i] = Polygonoid:new()
		--self.Entities[i].position.x = math.random(-love.graphics.getWidth(),love.graphics.getWidth())
		self.Entities[i].position.x = math.random(0,love.graphics.getWidth())
		--self.Entities[i].position.y = math.random(-love.graphics.getHeight(),love.graphics.getHeight())
		self.Entities[i].position.y = math.random(0,love.graphics.getHeight())
		self.Entities[i].velocity.x = math.random(-5,5)
		self.Entities[i].velocity.y = math.random(-5,5)
		self.Entities[i]:load(self.World)
	end

end

function Level:update(dt)
	--self.World:update(dt)
	for k,v in pairs(self.Entities) do
		self.Entities[k]:update(dt)
	end

	
end

function Level:draw()
	for i=1,#self.Entities do
		self.Entities[i]:draw()
	end

end


return Level
