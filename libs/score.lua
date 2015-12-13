local score = {}

score.getPlayerScore = function(score)
	local file

	local path = system.pathForFile( "score.txt", system.DocumentsDirectory )
	
	file = io.open(path, "r")

	if not file then
		file = io.open(path, "w")
		file:write(tostring(score))
	end
	io.close(file)

	file = io.open(path, "r")
	local savedData = file:read( "*a" )
	if tonumber(savedData) < score then
		io.close(file)
		file = io.open(path, "w")
		file:write(tostring(score))
		savedData = score
	end

	io.close(file)
	file = nil

	return savedData

end

return score