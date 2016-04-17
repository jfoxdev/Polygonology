local Highscores = {
	file = "highscores.csv",
	handle = {},
	Ladder = {}
}

function Highscores:save(name, score, time)
	-- Save Ladder to highscores.csv

	local file = love.filesystem.newFile( "highscores.csv" )
	file:open("a")
	--file:append(""..name..","..score..","..time.."\r\n")
	love.filesystem.append( "highscores.csv", ""..name..","..score..","..time.."\r\n")
	file:close()
end

function Highscores:load()
	-- Open highscores.csv and add each to Ladder
	
	local file = love.filesystem.newFile( "highscores.csv" )
	file:open("r")
	data, size = file:read()
	file:close()
	if size == 0 then 
		data = "No Highscores Available"
	end
	return data
end

function Highscores:add(name, score, time)
	-- Insert score,name,time into Ladder in proper position
end

return Highscores
