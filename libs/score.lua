local score = {}

score.getPlayerScore = function(score)
	local file

	local path = system.pathForFile( "score.txt", system.DocumentsDirectory )

	local function checkScore()
		file = io.open(path, "r")

		if file then
			local savedData = file:read( "*a" )
			io.close(file)
			file = nil

			print("Saved Data: "..savedData)
			if savedData == 0 then
				return nil 
			else
				if score then
					if tostring(score) ~= savedData then
						print("CHECKING NEW SCORE")
						return nil
					else
						return savedData
					end
				else
					return savedData
				end
				
			end
		end
	end

	local checked = checkId()
	
	if not checked then
		file = io.open(path, "w")
		if id then
			file:write(tostring(id))
		else
			file:write(0)
		end

		io.close(file)

		return checkId()
	else
		return checked
	end

	return nil
end

return score