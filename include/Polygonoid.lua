require( "include.Common" )

local Polygonoid = {
	id = "",
	name = "Polygonoid",
	score = 0,
	level = 1,

	position = { 
		x = 0, y = 0,
		x2 = 0, y2 = 0 
	},
	velocity = { x = 0, y = 0 },
	dimensions = { w = 1, h = 1 },
	mass = 1.0,
	rotation = 0,
	Body = {},
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
	Points = { 0,0,0,10,10,0 }
	
}

function Polygonoid:new(o)
	if o == nil then 
		o = {}
	else
		o = DeepCopy(o)
		o.position = DeepCopy(o.position)
		o.velocity = DeepCopy(o.velocity)
		o.ActiveColor = DeepCopy(o.ActiveColor)
		o.Polygon = DeepCopy(o.Polygon)
		o.Polygon.points = DeepCopy(o.Polygon.points)
		o.Points = DeepCopy(o.Points)
	end
	
	--o = o or {}   -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function Polygonoid:load(world)

	self.position.x = math.random(0,love.graphics.getWidth())
	self.position.y = math.random(0,love.graphics.getHeight())
	
	self.Polygon.segments = math.random(3,6)
	for i=1,self.Polygon.segments*2-1 do

		if i%2 == 0 then
			table.insert(self.Polygon.points, i, math.random(-5,5) )
		else
			table.insert(self.Polygon.points, i, math.random(-5,5) )
		end

	end

	self.mass = math.random(0,30) * 0.1
	if world ~= nil then
		body = love.physics.newBody( world, self.position.x, self.position.y, "dynamic" )
	end

	print("Loaded Polygonoid: x="..self.position.x..",y="..self.position.y)
end



function Polygonoid:update(dt)
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
	self.Points[2] = self.position.y
	self.Points[3] = self.position.x
	self.Points[4] = self.position.y + (10 + self.mass)
	self.Points[5] = self.position.x + (10 + self.mass)
	self.Points[6] = self.position.y
end

function Polygonoid:draw()
    love.graphics.translate(self.position.x, self.position.y)
	love.graphics.rotate(self.rotation) -- this is in radians
	love.graphics.scale(1 * self.mass, 1 * self.mass)

	love.graphics.setColor(
		self.ActiveColor.r * 255,
		self.ActiveColor.g * 255,
		self.ActiveColor.b * 255,
		self.ActiveColor.a * 255
	)
	love.graphics.setLineStyle( "smooth" )
	--love.graphics.line( self.position.x, self.position.y, self.position.x2, self.position.y2 )
	love.graphics.polygon( "fill", self.Points )

	love.graphics.polygon( "fill", self.Polygon.points )

	for i=1,#self.Polygon do
		--love.graphics.line( self.position.x, self.position.y, self.position.x2, self.position.y2 )
		--drawline  Polygon[i]
	end
end


function Polygonoid:Accelerate()
	self.velocity.x = self.velocity.x + (math.cos(self.rotation/360 * math.pi) * 10)
	self.velocity.y = self.velocity.y + (math.sin(self.rotation/360 * math.pi) * 10)
end

function Polygonoid:Decelerate()
	self.velocity.x = self.velocity.x - (math.cos(self.rotation/360 * math.pi) * 10)
	self.velocity.y = self.velocity.y - (math.sin(self.rotation/360 * math.pi) * 10)
end

function Polygonoid:RotateLeft()
	self.rotation = self.rotation - 5
end

function Polygonoid:RotateRight()
	self.rotation = self.rotation + 5
end

function Polygonoid:Boost()
	self.mass = self.mass + 1
end

function Polygonoid:Deflect()

end

return Polygonoid
