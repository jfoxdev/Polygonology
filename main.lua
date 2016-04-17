--local Input = require("include.Input")
--local Audio = require("include.Audio")
--local Level = require("include.Level")
--local Player = require("include.Player")
--local Entity = require("include.Entity")

local StateManager = require( "include.StateManager" )
local GameState = require( "include.GameState" )
local Camera = require( "include.Camera" )

function love.load()
	print("Polygonology Loading...")
	math.randomseed(os.time())
	StateManager:load("Titlescreen", true)
	StateManager:load("GamePlay", false)
	StateManager:load("Scores", false)
	StateManager:load("Credits", false)
end

function love.update(dt)
	
	StateManager:update(dt)
	
end

function love.draw()
	StateManager:draw()
end


function love.resize( w, h )
	StateManager:resize(w,h)
end

function love.mousepressed(x,y,button,istouch)
	StateManager:mousepressed(x,y,button,istouch)
end

function love.mousereleased(x,y,button,istouch)
	StateManager:mousereleased(x,y,button,istouch)
end

function love.keypressed( key, scancode, isrepeat )
	-- Grab Screenshot Button
	if key == "f12" then
		local shot = love.graphics.newScreenshot();
		if shot:encode('png', "shot-" .. os.time() .. '.png') then
			print("Screenshot saved!") 
		end
	
	-- Toggle Fullscreen Button
	elseif key == "f11" then
		if love.window.getFullscreen() then
			love.window.setFullscreen( false )
		else
			love.window.setFullscreen( true )
		end
	-- Else just pass to the current gamestate
	else
		StateManager:keypressed( key, scancode, isrepeat )
	end
end

function love.keyreleased( key )
	StateManager:keyreleased( key )
end

