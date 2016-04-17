require( "include.Common" )

local Camera = {
	position = { x=0,y=0 },
	velocity = { x=0,y=0 },
	scale = { x=1.0,y=1.0 },
	rotation = 0
}


function Camera:set()
	love.graphics.push()
	love.graphics.translate(-self.position.x, -self.position.y)
	love.graphics.rotate(-self.rotation) -- this is in radians
	love.graphics.scale(self.scale.x, self.scale.y)
end

function Camera:unset()
	love.graphics.pop()
end

function Camera:update(dt)
	
end

function Camera:setPosition(x,y)
	self.position.x = (x or 0)
	self.position.y = (y or 0)
end

function Camera:setFocus(x,y)
	self.position.x = (x or 0) - love.graphics.getWidth()/2
	self.position.y = (y or 0) - love.graphics.getHeight()/2
end

function Camera:setScale(sx,sy)
	self.scale.x = (sx or self.scale.x)
	self.scale.y = (sy or self.scale.y)
end

function Camera:setRotation(r)
	self.rotation = (r or 0)
end

function Camera:new(o)
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

return Camera
