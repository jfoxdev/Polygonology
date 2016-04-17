require( "include.Common" )

local Polymitter = {
	id = "",
	name = "Polymitter",

	position = { 
		x = 0, y = 0
	},
	velocity = { x = 0, y = 0 },
	
	ActiveColor = {r=0.5,g=0.5,b=1.0,a=1.0},
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
		o.ActiveColor = DeepCopy(o.ActiveColor)
		o.Colors = DeepCopy(o.ActiveColor)
		o.Colors.Good = DeepCopy(o.Colors.Good)
		o.Colors.Bad = DeepCopy(o.Colors.Bad)
	end
	
	--o = o or {}   -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function Polymitter:load(x,y,world)

	self.position.x = x
	self.position.y = y
	print("Loaded Polymitter: x="..self.position.x..",y="..self.position.y)
	
end



function Polymitter:update(dt)
	-- if score, change color and fade back to default
	self.Cooldown = self.Cooldown - dt
	if self.Cooldown < 0 then
		--Create a new Polygonoid
		self.Cooldown = math.random(1,30) * 0.1
	end

end

function Polymitter:draw()
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


function Polymitter:Accelerate()
	self.velocity.x = self.velocity.x + (math.cos(self.rotation/360 * math.pi) * 10)
	self.velocity.y = self.velocity.y + (math.sin(self.rotation/360 * math.pi) * 10)
end

function Polymitter:Decelerate()
	self.velocity.x = self.velocity.x - (math.cos(self.rotation/360 * math.pi) * 10)
	self.velocity.y = self.velocity.y - (math.sin(self.rotation/360 * math.pi) * 10)
end

function Polymitter:RotateLeft()
	self.rotation = self.rotation - 5
end

function Polymitter:RotateRight()
	self.rotation = self.rotation + 5
end

function Polymitter:Boost()
	self.mass = self.mass + 1
end

function Polymitter:Deflect()

end

return Polymitter
