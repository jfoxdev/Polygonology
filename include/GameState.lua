local GameState = {
	self = nil,
	enabled = false
}
--require ("include.StateManager")
--require ("include.Common")

function GameState:new(o)
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

function GameState:load()
	print("GameState:load()")
end

function GameState:unload()
	print("GameState:unload()")
end

function GameState:update(dt)
	print("GameState:update("..dt..")")
end

function GameState:draw()
	print("GameState:draw()")
end



--[[
--	Input Callbacks
--]]
function GameState:mousepressed(x,y,button,istouch)
	print("GameState:mousepressed()")
end
function GameState:mousereleased(x,y,button,istouch)
	print("GameState:mousereleased()")
end

function GameState:keypressed( key, scancode, isrepeat )
	print("GameState:keypressed()")
end

function GameState:keyreleased( key )
	print("GameState:keyreleased()")
end

function GameState:resize(w,h)
	print("GameState:resize()")
end


--[[
--		GameState functions
--]]

function GameState:ChangeState()
	print("GameState:ChangeState()")
end

function GameState:getNextState()
	print("GameState:getNextState()")
end

return GameState
