require ("include.Common")
local Player = {
	id = "",
	name = "Player",
	score = 0,
	level = 1,

	position = { 
		x = 0, y = 0,
		x2 = 0, y2 = 0 
	},
	velocity = { x = 0, y = 0 },
	dimensions = { w = 1, h = 1 },
	mass = 1,
	rotation = 0,

	ActiveColor = {r=0.5,g=0.5,b=1.0,a=1.0},
	Colors = {
		Idle = {r=0.5,g=0.5,b=1.0,a=1.0},
		Good = {r=1.0,g=0.0,b=0.0,a=1.0},
		Bad = {r=1.0,g=0.0,b=0.0,a=1.0}
	},
	Polygon = {
		segments = 1,
		size = 1.0,
		density = 1.0,
		angle = 180,
		points = { }
	},
	Points = { 0,5,5,0,-5,0 }
	
}

local Camera = require ("include.Camera")

function Player:new()	
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

function Player:load()
	--self.position.x = love.graphics.getWidth() / 2
	--self.position.y = love.graphics.getHeight() / 2

	self.Polygon.segments = 3
	for i=1,self.Polygon.segments*2 do

		if i%2 == 0 then
			table.insert(self.Polygon.points, i, math.random(-5,5) )
		else
			table.insert(self.Polygon.points, i, math.random(-5,5) )
		end

	end

end



function Player:update(dt)
	-- if score, change color and fade back to default

	self.position.x = self.position.x + ( self.velocity.x * dt )
	self.position.y = self.position.y + ( self.velocity.y * dt )
	
	self.position.x2 = self.position.x + (math.cos(self.rotation/360 * math.pi) + 10)
	self.position.y2 = self.position.y + (math.sin(self.rotation/360 * math.pi) + 10)
	
	
	for i=1,#self.Polygon.points do 
		if i%2 == 0 then
			self.Polygon.points[i] = self.Polygon.points[i] + ( self.velocity.y * dt )
		else
			self.Polygon.points[i] = self.Polygon.points[i] + ( self.velocity.x * dt )
		end
	end

	self.Points[1] = self.position.x
	self.Points[2] = self.position.y + 10
	self.Points[3] = self.position.x + 5
	self.Points[4] = self.position.y
	self.Points[5] = self.position.x - 5
	self.Points[6] = self.position.y
end

function Player:draw()
	--love.graphics.translate(0,0)
	--love.graphics.translate(self.position.x, self.position.y)
	--love.graphics.translate(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
	--love.graphics.rotate(self.rotation) -- this is in radians
	--love.graphics.scale(1 * self.mass, 1 * self.mass)

	love.graphics.setColor(
		self.ActiveColor.r * 255,
		self.ActiveColor.g * 255,
		self.ActiveColor.b * 255,
		self.ActiveColor.a * 100
	)
	love.graphics.setLineStyle( "smooth" )
	love.graphics.polygon( "fill", self.Polygon.points )
	love.graphics.setColor(
		200,
		200,
		200,
		128
	)
	love.graphics.polygon( "line", self.Polygon.points )

end


function Player:Accelerate()
	print("Accelerate!")
	self.velocity.x = self.velocity.x + (math.cos(self.rotation/360 * math.pi) * 10)
	self.velocity.y = self.velocity.y + (math.sin(self.rotation/360 * math.pi) * 10)
end

function Player:Decelerate()
	print("Decelerate!")
	self.velocity.x = self.velocity.x - (math.cos(self.rotation/360 * math.pi) * 10)
	self.velocity.y = self.velocity.y - (math.sin(self.rotation/360 * math.pi) * 10)

end

function Player:RotateLeft()
	print("RotateLeft!")
	self.rotation = self.rotation - 5
end

function Player:RotateRight()
	print("RotateRight!")
	self.rotation = self.rotation + 5
end

function Player:Boost()
	print("Boost!")
	self.mass = self.mass + 1
	self.score = self.score + 1
end

function Player:Deflect()
	print("Deflect!")
	Player:AddPoint()

end


function Player:AddPoint(x,y)
	local size = self.Polygon.size
	local pos = #self.Polygon.points
	if x == nil then
		table.insert(self.Polygon.points, pos, math.random(-5*size,5*size) )
	else
		table.insert(self.Polygon.points, pos, x)
	end

	pos = #self.Polygon.points
	if y == nil then
		table.insert(self.Polygon.points, pos, math.random(-5*size,5*size) )
	else
		table.insert(self.Polygon.points, pos, y)
	end

	
	self.score = self.score + 100
	if self.score > 2500 then 
		self.score = self.score - 2500
		self.level = self.level + 1
	end
	self.Polygon.segments = self.Polygon.segments + 1
	self.mass = self.mass + 0.1
	self.Polygon.size = self.Polygon.size + 0.1
end

return Player
