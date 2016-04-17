require( "include.Common" )
local Polygonoid = require( "include.Polygonoid" )
local Polymitter = {
	id = "",
	name = "Polymitter",
	position = { x = 0, y = 0 },
	velocity = { x = 0, y = 0 },
	
	PS = {},		--Particle System
	Texture = {},	--Particle Texture
	ActiveColor = {r=0.0,g=0.5,b=1.0,a=1.0},	-- Active Color
	Colors = {
		Good = {r=0.0,g=1.0,b=0.0,a=1.0},
		Bad = {r=1.0,g=0.0,b=0.0,a=1.0}
	},
	Cooldown = 2,
}

function Polymitter:new(o)
	if o == nil then 
		o = {}
	else
		o = DeepCopy(o)
		o.position = DeepCopy(o.position)
		o.velocity = DeepCopy(o.velocity)
		--o.PS = DeepCopy(o.PS)
		o.Texture = DeepCopy(o.Texture)
		o.ActiveColor = DeepCopy(o.ActiveColor)
		o.Colors = DeepCopy(o.Colors)
		o.Colors.Good = DeepCopy(o.Colors.Good)
		o.Colors.Bad = DeepCopy(o.Colors.Bad)
	end
	
	--o = o or {}   -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function Polymitter:load(x,y,world)

	if x == nil then x = math.random(0,10) end
	if y == nil then y = math.random(0,10) end
	self.position.x = x
	self.position.y = y
	
	
	self.Texture = love.graphics.newImage("assets/particle.png")
	
	self.PS = love.graphics.newParticleSystem(self.Texture, 20 )
	self.PS:setEmitterLifetime(-1)
	self.PS:setLinearAcceleration(5,5)
	self.PS:setSpin( 0, 2*math.pi )
	self.PS:setSpinVariation(1)
	self.PS:setParticleLifetime(0.5, 1, 2, 5)
	self.PS:setColors(
		self.ActiveColor.r * 255,
		self.ActiveColor.g * 255,
		self.ActiveColor.b * 255,
		self.ActiveColor.a * 255
	)
	self.PS:setSizes(0.25,0.5,0.75,2, 5)
	self.PS:setEmissionRate(1)

	self.PS:start()

	self.PS:setPosition(self.position.x, self.position.y)
	print("Loaded Polymitter: x="..self.position.x..",y="..self.position.y)
end



function Polymitter:update(dt)
	self.PS:update( dt )
	--self.PS:setPosition(0,0)

	-- if score, change color and fade back to default
	self.Cooldown = self.Cooldown - dt
	if self.Cooldown < 0 then
		--Create a new Polygonoid
		self.Cooldown = math.random(1,3) * 0.1
		self.PS:emit( 20 )
	end

end

function Polymitter:draw()
	
	self.PS:setColors(
		self.ActiveColor.r * 255,
		self.ActiveColor.g * 255,
		self.ActiveColor.b * 255,
		self.ActiveColor.a * 255
	)
	--love.graphics.draw(self.PS, self.position.x, self.position.y)
	love.graphics.draw(self.PS, 0,0)

end


function Polymitter:Accelerate()
end

function Polymitter:Decelerate()
end

function Polymitter:RotateLeft()
end

function Polymitter:RotateRight()
end

function Polymitter:Boost()
end

function Polymitter:Deflect()

end

function Polymitter:Spawn(segments, vx, vy)
	local poly = Polygonoid:new()
	poly.position.x = self.position.x
	poly.position.y = self.position.y
	poly.velocity.x = math.random(-5,5)
	poly.velocity.y = math.random(-5,5)
	--[[
	if math.random(0,1) == 1 then
		poly.ActiveColor = poly.Colors.Bad
	else
		poly.ActiveColor = poly.Colors.Good
	end
	]]
	return poly
end

return Polymitter
