--[[
--		@brief Check if a value is empty
--		@returns true if nil or empty string
--]]
function isEmpty(s)
	return s == nil or s == ''
end

--[[
--		@param F filename
--		@brief Import a Wordlist
--		@returns table (array) of words
--]]
function ImportWordlist(F)
	io.write("Importing Wordlist: ", F, "\n")
	io.input(F)
	local count = 1
	local T = {}
	while true do
		local line = io.read()
		if line == nil then 
			break 
		end
		T[count] = line
		count = count + 1
	end
	return T
end

--[[
--		@brief	Set an optional default value for a variable
--		@details Uses the passed default value if no user value is empty
--		@returns var or default
--]]
function orDefault(var, default)
	if isEmpty(var) then
		var = default
	end
	return var
end

--[[
--		@brief Count the number of items in a table
--		@returns number of items
--]]
function TableLength(T)
	local count = 0
		for _ in pairs(T) do count = count + 1 end
	return count
end

--[[
--		@brief	Prints a table to stdout
--]]
function PrintTable(table)
	for k,v in pairs(table) do print(k,v) end
end

--[[
--		@brief Deep Copy a Table
--]]
function DeepCopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function Fade(colorBegin, colorEnd, duration, step)
	tmpColor = {r=0.0,g=0.0,b=0.0,a=0.0}

	r = ( colorEnd.r - colorBegin.r) * (step / duration)
	g = ( colorEnd.g - colorBegin.g) * (step / duration)
	b = ( colorEnd.b - colorBegin.b) * (step / duration)
	a = ( colorEnd.a - colorBegin.a) * (step / duration)

	tmpColor.r = colorBegin.r + r
	tmpColor.g = colorBegin.g + g
	tmpColor.b = colorBegin.b + b
	tmpColor.a = colorBegin.a + a

	return tmpColor
end
