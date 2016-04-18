local StateManager = require ("include.StateManager")
local Highscores = require ("include.Highscores")
local Polygonoid = require ("include.Polygonoid")
require ("include.Common")

local GamePlay = {
	self = nil,
	World = {},
	Image = nil,
	isPaused = false,
	Font = {},
	Level = {},
	Player = {},
	Entities = {},
	ClockFont = {},
	GameTime = 60,
	Damage = false,
	enabled = false
}


--local Input = require("include.Input")
--local Audio = require("include.Audio")
--local Level = require("include.Level")
--local Entity = require("include.Entity")

local Camera = require ("include.Camera")
local Level = require ("include.Level")
local Player = require ( "include.Player" )
local Entities = {}

local TimerMax = 5
local Timer = 1
local SmashNoise = love.audio.newSource("assets/smash.ogg", "static")

function GamePlay:new(o)
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

function GamePlay:load()
	print("Polygonology Play Loading...")
	--love.keyboard.setKeyRepeat( true )
	self.World = love.physics.newWorld( 0, 0, true)
    self.World:setCallbacks(beginContact, endContact, preSolve, postSolve)
	love.physics.setMeter(32) -- set 32 pixels/meter

	self.Level = Level:new()
	self.Level:load(self.World)
	
	self.Player = Player:new()
	self.Player:load(self.World)

	self.Font = love.graphics.newFont( "assets/Hack.ttf", 16 )
	self.ClockFont = love.graphics.newFont( "assets/Hack.ttf", 32)
	
	GamePlay:buildPolygonoid(
		math.random(0,love.graphics.getWidth()),
		math.random(0,love.graphics.getHeight()),
		math.random(-1,10),
		math.random(0,10), 
		tmpcolor, math.random(4,10))
end

function GamePlay:unload()

end

function GamePlay:update(dt)
	
	self.World:update(dt)

	self.GameTime = self.GameTime - dt
	
	Timer = Timer - dt
	if Timer < 0 then
		--self.Player:AddPoint()
		Timer = math.random(0,TimerMax)
		
		
		local tmpcolor = {}
		if math.random(0,1) == 0 then
			tmpcolor = {r=0.0,g=1.0,b=0.0,a=1.0}
			self.Damage = false
		else
			tmpcolor = {r=1.0,g=0.0,b=0.0,a=1.0}
			self.Damage = true
		end

		local n = math.random(1,4)
		--GamePlay:buildPolygonoid(10,10,math.random(-1,10),math.random(0,10), tmpcolor, math.random(4,10))
		GamePlay:buildPolygonoid(
			math.random(0,love.graphics.getWidth()),
			math.random(0,love.graphics.getHeight()),
			math.random(-1,10),
			math.random(0,10), 
			tmpcolor, math.random(4,10))

	end
	
	self.Player:update(dt)
	self.Level:update(dt)
	
	for k,v in pairs(self.Entities) do
		self.Entities[k]:update(dt)
		if self.Entities[k].Duration < 0 then
			self.Entities[k] = nil
		end
	end

	if self.GameTime < -3 then
		Highscores:save("Polygonology Player [".. self.Player.level .."]", self.Player.score, os.time())
		StateManager:SwitchTo("Scores")
	end

end


function GamePlay:draw()
	
	Camera:set()
	
	
	
	--[[Camera:setFocus(
		self.Player.position.x, 
		self.Player.position.y
	)]]
	Camera:setFocus(
		love.graphics.getWidth()/2, 
		love.graphics.getHeight()/2
	)

	self.Player:draw()


	Camera:setPosition(0,0)
	self.Level:draw()
	
	Camera:setPosition(0,0)
	
	for k,v in pairs(self.Entities) do
		self.Entities[k]:draw()
	end


	-- Display Time
	if self.GameTime < 0 then
		--TIMES UP!
		love.graphics.setColor(200,200,0,220)
		love.graphics.setFont(self.ClockFont);
		love.graphics.print("Times Up!", 10, 10);
	else
		love.graphics.setColor(200,200,0,220)
		love.graphics.setFont(self.ClockFont);
		love.graphics.print(string.format("Time: %i",self.GameTime), 10, 10);
	end
	-- Display Player Status
	love.graphics.setColor(50,255,50,220)
	love.graphics.setFont(self.Font);
	love.graphics.print("Level: "..self.Player.level, 10, 50);
	love.graphics.print("Score: "..self.Player.score, 10, 66);
	love.graphics.print("Mass: "..self.Player.mass, 10, 82);
	love.graphics.print("Segments: "..self.Player.Polygon.segments, 10, 98);
	



	Camera:unset()
end

function GamePlay:ChangeState()
	return false
end
function GamePlay:getNextState()
	-- find cursor collisions with buttons
end

function GamePlay:mousepressed(x,y,button,istouch)
	print("GamePlay:mousepressed() ---> " .. x .. ","..y..","..button.."\n")
end
function GamePlay:mousereleased(x,y,button,istouch)
	print("GamePlay:mousereleased() ---> " .. x .. ","..y..","..button.."\n")
end

function GamePlay:keypressed( key, scancode, isrepeat )
	print("GamePlay:keypressed() ---> " .. key )

	if key == "escape" then
		--Throw State Change to Credits
		StateManager:SwitchTo("Titlescreen")
	end

	if key == "f1" then
		print("Saving score...")
		Highscores:save("Player Name [".. self.Player.level .."]", self.Player.score, os.time())
	end

	local isDown = love.keyboard.isDown

	if isDown("w") or isDown("up") then
		self.Player:Up()
	end

	if isDown("s") or isDown("down") then
		self.Player:Down()
	end

	if isDown("a") or isDown("left") then
		self.Player:Left()
	end

	if isDown("d") or isDown("right") then
		self.Player:Right()
	end

	if isDown("space") then
		--Player:Deflect()
		--self.Level.Polymitters[1]:Spawn(3, 100,100)
		--self.Player:AddPoint()
	end
	if isDown("lshift") then
		--self.Player:RemovePoint()
	end


end

function GamePlay:keyreleased( key )
	print("GamePlay:keyreleased() ---> " .. key )
end

function GamePlay:resize(w,h)

	cx = w / 2
	cy = h / 2

	Level:resize(w,h)
end


function GamePlay:buildPolygonoid(x,y,vx,vy,color,duration)
	
	local poly = Polygonoid:new()
	poly:load(self.World)
	poly.position.x = x
	poly.position.y = y

	poly.velocity.x = vx
	poly.velocity.y = vy
	poly.ActiveColor = color

	--[[
	if math.random(0,1) == 1 then
		poly.ActiveColor = poly.Colors.Bad
	else
		poly.ActiveColor = poly.Colors.Good
	end
	]]

	table.insert(self.Entities, #self.Entities+1, poly)

end


function beginContact(a, b, coll)
end
 
function endContact(a, b, coll)
end
 
function preSolve(a, b, coll)

	if a:getUserData().value == "Player" and
	 	b:getUserData().value == "Polygonoid" then
	
		--print("CONTACT CALLBACK!")
		--print("A",a:getUserData().value)
		--print("B",b:getUserData().value)

		if GamePlay.Damage == true then
		  	GamePlay.Player:RemovePoint()
		  	GamePlay.Player.score = GamePlay.Player.score - 10
			if GamePlay.Player.score < 0 then GamePlay.Player.score = 0 end
			love.audio.play(SmashNoise)
		else
		  	GamePlay.Player:AddPoint()
			love.audio.play(SmashNoise)
		end
	end

end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end





return GamePlay
