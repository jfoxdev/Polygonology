local StateManager = {
	Current = nil,
	Next = nil,
	States = {},
	trigger = false
}

function StateManager:load(name, enabled)
	--Current:load()
	self.States[name] = require("gamestates."..name)
	self.States[name]:load()
	if enabled ~= nil then
		self.States[name].enabled = enabled
	end
end


function StateManager:SwitchTo(state)
	
	if self.States[state] == nil then 
		return 
	end
	
	for k,v in pairs(self.States) do 
		if k == state then
			self.States[k].enabled = true
		else
			self.States[k].enabled = false
		end

	end

end




function StateManager:unload(state)
	if state ~= nil then
		if self.States[state] ~= nil then
			self.States[state]:unload()
		end
	else
		Current:unload()
	end
end

function StateManager:update(dt)
	for k,v in pairs(self.States) do 
		if self.States[k].enabled then
			self.States[k]:update(dt)
		end
	end
end

function StateManager:draw()
	for k,v in pairs(self.States) do 
		if self.States[k].enabled then
			self.States[k]:draw()
		end
	end
end

function StateManager:mousepressed(x,y,button,istouch)
	for k,v in pairs(self.States) do 
		if self.States[k].enabled then
			self.States[k]:mousepressed(x,y,button,istouch)
		end
	end

end

function StateManager:mousereleased(x,y,button,istouch)
	for k,v in pairs(self.States) do 
		if self.States[k].enabled then
			self.States[k]:mousereleased(x,y,button,istouch)
		end
	end
end

function StateManager:keypressed( key, scancode, isrepeat )
	for k,v in pairs(self.States) do 
		if self.States[k].enabled then
			self.States[k]:keypressed(key, scancode, isrepeat)
		end
	end
end

function StateManager:keyreleased( key )
	for k,v in pairs(self.States) do 
		if self.States[k].enabled then
			self.States[k]:keyreleased( key )
		end
	end
end

function StateManager:resize( w, h )	
	for k,v in pairs(self.States) do 
		if self.States[k].enabled then
			self.States[k]:resize( w, h )
		end
	end
end
return StateManager
