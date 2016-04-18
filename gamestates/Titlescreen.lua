local StateManager = require ("include.StateManager")
local Menu = require ("include.Menu")

require ("include.Common")

local Titlescreen = {
	self = nil,
	Image = nil,
	Music = nil,
	ClickNoise = nil,
	enabled = false
}

local cx = love.graphics.getWidth() / 2
local cy = love.graphics.getHeight() / 2
local offx = 0
local offy = 0

local PlayButton = function() StateManager:SwitchTo("GamePlay") end
local ScoresButton = function() StateManager:SwitchTo("Scores") end
local QuitButton = function() StateManager:SwitchTo("Credits") end


function Titlescreen:new(o)
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

function Titlescreen:load()
	print("Polygonology Titlescreen Loading...")
	self.Image = love.graphics.newImage( "assets/polygonology.png" )
	ox = self.Image:getWidth()/2
	oy = self.Image:getHeight()/2
	
	self.Music = love.audio.newSource("assets/menu.ogg", "stream")
	self.ClickNoise = love.audio.newSource("assets/smash.ogg", "static")


	Menu:add(1, "Play", "assets/play.png", PlayButton)
	Menu:add(2, "Scores", "assets/scores.png", ScoresButton)
	Menu:add(3, "Quit", "assets/quit.png", QuitButton)
	Menu:print()
	
	love.audio.play(self.Music)
end

function Titlescreen:unload()

end

function Titlescreen:update(dt)
	-- find cursor collisions with buttons
end

function Titlescreen:ChangeState()
	return false
end
function Titlescreen:getNextState()
	-- find cursor collisions with buttons
end


function Titlescreen:draw()
	--love.graphics.print('Polygonology', 400, 300)
	love.graphics.setColor( 0, 255, 0, 255 )	
	love.graphics.draw( self.Image, cx - ox, 50, 0, 1, 1, 0, 0, 0, 0 )
	
	for i=1,#Menu.Items do
		local bx = Menu.Items[i].Image:getWidth() / 2
		local color = {}
		if Menu.Active == i  then
			color = Menu.Colors.foreground.selected
		else
			color = Menu.Colors.foreground.default
		end
		
		love.graphics.setColor( 255 * color.r, 255 * color.g, 255 * color.b, 255 * color.a )	
		love.graphics.draw( Menu.Items[i].Image, cx - bx, self.Image:getHeight() + i * 120, 0, 1, 1, 0, 0, 0, 0 )
	end

end


function Titlescreen:mousepressed(x,y,button,istouch)
	print("Titlescreen:mousepressed() ---> " .. x .. ","..y..","..button.."\n")
	--love.audio.play(self.ClickNoise)
end
function Titlescreen:mousereleased(x,y,button,istouch)
	print("Titlescreen:mousereleased() ---> " .. x .. ","..y..","..button.."\n")
end

function Titlescreen:keypressed( key, scancode, isrepeat )
	print("Titlescreen:keypressed() ---> " .. key )

	if self.enabled and key == "escape" then
		--Throw State Change to Credits
		QuitButton()
	end

	if key == "return" then
		print("Menu.Item : " .. Menu.Active .. "\n")
		if Menu.Items[Menu.Active].onClickCallback ~= nil then
			Menu.Items[Menu.Active].onClickCallback()
		end
	end

	if key == "w" or key == "up" then
		Menu.Active = Menu.Active - 1
	end
	if key == "s" or key == "down" then
		Menu.Active = Menu.Active + 1
	end

	if Menu.Active > #Menu.Items then Menu.Active = 1 end
	if Menu.Active < 1 then Menu.Active = #Menu.Items end

end

function Titlescreen:keyreleased( key )
	print("Titlescreen:keyreleased() ---> " .. key )
end

function Titlescreen:resize(w,h)

	cx = w / 2
	cy = h / 2

end


return Titlescreen
