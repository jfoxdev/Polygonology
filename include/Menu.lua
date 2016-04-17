--[[
--	@class Menu
--	@brief Menu Helper Class
]]
local Menu = {
	Instance = nil,
	Parent = nil,
	x = 0, y = 0,
	w = 0, h = 0,
	id = nil, 
	label = "",
	state = "default",
	onClickCallback = nil,
	onKeypressCallback = nil,
	
	Colors = {
		background = {
			default = {r=0.5,g=0.5,b=0.5,a=0.5},
			selected = {r=1.0,g=1.0,b=1.0,a=0.8},
		},
		foreground = {
			default = {r=0.5,g=0.5,b=0.5,a=0.75},
			selected = {r=1.0,g=1.0,b=1.0,a=1.0},
		}
	},
	Font = nil,
	TextSize = 14,
	Items = {},
	Active = 1,
}

function Menu:init(id)
	if id == nil then id = "menu" end
	self.id = id
end

function Menu:add(id, label, image, click)
	self.Items[id] = {}
	self.Items[id].label = label
	self.Items[id].onClickCallback = click

	--TODO: if image == nil, Image = createText( label )
	self.Items[id].Color = self.Colors.foreground.default
	self.Items[id].Image = love.graphics.newImage( image )
	self.Items[id].Collidable = { w=0, h=0 }
end

function Menu:remove(id)
	--todo: not needed?
end

function Menu:build(x,y,w,h)
	
	-- start at x,y
	-- place button at  (love.graphics.getWidth()/2 - w/2)
	-- add h to y for each button
	for k,v in pairs(self.Items) do
		
		if self.Items[k].Image == nil then
			self.Items[k].Image = love.graphics.newImage( image )
		end

	end
end

function Menu:print()
	io.write("Menu: ", self.label.."\n")
	
	for k,v in pairs(self.Items) do
		io.write(" ", k, ": ", self.Items[k].label,  "\n")
	end
end

function Menu:update(dt)
	if dt == nil then dt = 0 end

	for k,v in pairs(self.Items) do
--[[
		if v.entity:getCollidableComponent():isSelected() then	
			self.Items[k].entity:getGraphicsComponent():getTexture():setColor( self.active_color.r,self.active_color.g, self.active_color.b )
			if v.hover ~= nil then v.hover() end
		else
			self.Items[k].entity:getGraphicsComponent():getTexture():setColor( self.base_color.r,self.base_color.g, self.base_color.b )
		end

		if v.entity:getCollidableComponent():isActivated() then
			if v.click ~= nil then
				v.click()
				v.entity:getCollidableComponent():setActivatedFlag(false)
			end
		end
]]
	end

end

--[[
--		Update the metatable for Menu
--]]
local metatable = {
	__call = function()
		local self = {}
		setmetatable(self, { __index = Menu })
		return self
	end
}
setmetatable(Menu, metatable)

return Menu
