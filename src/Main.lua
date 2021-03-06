--[[Valmir Torres de Jesus Junior
	date: 23-04-2019

	The compiler made in Lua that receives a .vt file
	and translates to C language.
]]

-- import packages
local Utils = require("utils/Utils")
local Syntactic = require("interpreter/syntactic/Syntactic")
local Commons = require("interpreter/common/Commons")

local SIZE_STRING = 256

local start_compiler = function ()
	local file
	--defining the header of program.c
	file = '#include <stdio.h>\ntypedef char lit['..SIZE_STRING..'];\n\nvoid main (void) {\n@'

	file = Syntactic.analyze(file)

	--create temporary variables
	if Commons.number_var > 0 then
		file = string.gsub(file, '@', '/*----Temporary variables----*/\n@')
		for i = 1, Commons.number_var do
			file = string.gsub(file, '@', 'int T'..i..';\n@')
		end
		file = string.gsub(file, '@', '/*-----------------------------*/\n@')
	end
	file = string.gsub(file, '@', '')
	--Finishing the program.c
	file = file..'}\n'
	if not Commons.error then
		Utils.create_file(file)
	end
end

--call the function
start_compiler()