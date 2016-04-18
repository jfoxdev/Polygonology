require( "include.Common" )

local Polygonoid = {
	id = "",
	name = "Polygonoid",
	position = { 
		x = 0, y = 0
	},
	velocity = { x = 0, y = 0 },
	dimensions = { w = 1, h = 1 },
	mass = 1.0,
	rotation = 0,
	Body = nil,
	Shape = nil,
	Fixture = nil,
	ActiveColor = {r=0.5,g=0.5,b=1.0,a=0.7},
	Colors = {
		Idle = {r=0.5,g=0.5,b=1.0,a=0.7},
		Good = {r=1.0,g=0.0,b=0.0,a=0.7},
		Bad = {r=1.0,g=0.0,b=0.0,a=0.7}
	},
	Polygon = {
		segments = 1,
		size = 1.0,
		density = 1.0,
		angle = 180,
		points = { }
	},
	Duration = 5,
	damage = false
}

function Polygonoid:new(o)
	if o == nil then 
		o = {}
	else
		o = DeepCopy(o)
		o.position = DeepCopy(o.position)
		o.velocity = DeepCopy(o.velocity)
		o.ActiveColor = DeepCopy(o.ActiveColor)
		o.Colors = DeepCopy(o.Colors)
		o.Colors.Good = DeepCopy(o.Colors.Good)
		o.Colors.Bad = DeepCopy(o.Colors.Bad)
		o.Body = DeepCopy(o.Body)
		o.Shape = DeepCopy(o.Shape)
		o.Fixture = DeepCopy(o.Fixture)
		o.Polygon = DeepCopy(o.Polygon)
		o.Polygon.points = DeepCopy(o.Polygon.points)
	end
	
	--o = o or {}   -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function Polygonoid:load(world)

	self.position.x = math.random(0,love.graphics.getWidth())
	self.position.y = math.random(0,love.graphics.getHeight())
	
	self.Polygon.segments = math.random(3,4)
	for i=1,self.Polygon.segments*2 do

		if i%2 == 0 then
			table.insert(self.Polygon.points, i, math.random(-5,5) )
		else
			table.insert(self.Polygon.points, i, math.random(-5,5) )
		end
	end

	self.mass = math.random(0,30) * 0.1

	self.Body = love.physics.newBody( world, self.position.x, self.position.y, "dynamic" )
	self.Body:setMass(2)
	--self.Shape = love.physics.newCircleShape( self.Polygon.size )
	self.Shape = love.physics.newCircleShape( 50 )
	self.Fixture = love.physics.newFixture(self.Body, self.Shape)
	self.Fixture:setRestitution(1)
	self.Fixture:setUserData({type="Polygonoid",value=self.name})

	print("Loaded Polygonoid: x="..self.position.x..",y="..self.position.y)
end



function Polygonoid:update(dt)
	-- if score, change color and fade back to default
	self.Duration = self.Duration - dt
	self.position.x = self.position.x + ( self.velocity.x * dt )
	self.position.y = self.position.y + ( self.velocity.y * dt )
	
	for i=1,#self.Polygon.points do 
		if i%2 == 0 then
			self.Polygon.points[i] = self.Polygon.points[i] + ( self.velocity.y * dt )
		else
			self.Polygon.points[i] = self.Polygon.points[i] + ( self.velocity.x * dt )
		end
	end
	
	--self.Shape:setRadius( self.Polygon.size )
	self.Shape:setRadius( 50 )
	self.Body:setPosition( self.position.x, self.position.y)

end

function Polygonoid:draw()
	
	--[[
	love.graphics.setColor(
		self.ActiveColor.r * 255,
		self.ActiveColor.g * 255,
		self.ActiveColor.b * 255,
		self.ActiveColor.a * 150
	)
	love.graphics.setLineStyle( "smooth" )
	love.graphics.polygon( "fill", self.Polygon.points )

	]]
	love.graphics.setColor(
		self.ActiveColor.r * 255,
		self.ActiveColor.g * 255,
		self.ActiveColor.b * 255,
		self.ActiveColor.a * 200
	)
    love.graphics.circle("line", self.Body:getX(), self.Body:getY(), 50, 64)
	love.graphics.setColor(
		200,
		200,
		200,
		128
	)
	love.graphics.polygon( "line", self.Polygon.points )

end


function Polygonoid:Accelerate()
end

function Polygonoid:Decelerate()
end

function Polygonoid:RotateLeft()
end

function Polygonoid:RotateRight()
end

function Polygonoid:Boost()
end

function Polygonoid:Deflect()

end

return Polygonoid
