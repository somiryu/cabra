local physics = require( "physics" )
local Utils = require "libs.utils"
local objectSheet = require("libs.cabrawalk")

local llama= {}

collisionListener = function(e)
	
	if e.phase == "began" then
		print("COLLISION")
		if e.other.objType == "ground" then
			if e.target.state ~= "stand by" then 
				llama.changeSprite(e.target, "walk")
				e.target.state = "grounded"
			else
				llama.changeSprite(e.target, "standby")
			end
			e.target:setLinearVelocity( 0, 0 )
			e.target.canJump = 1
		end
	end
end

llama.new = function(group)
	local llama = llama.newCabraWalk
	llama.x = initialPos
	llama.y = display.contentHeight /2 - 150

	llama.width = 100
	llama.height = 100
	physics.addBody( llama, { density=8, friction=0, bounce=0 })
	llama:setLinearVelocity( 0, 0 )
	llama.isFixedRotation = true
	llama.canJump = 1
	llama.state = "stand by"
	llama.isSleepingAllowed = false
	llama:addEventListener( "collision", collisionListener )

	return llama
end

llama.changeSprite = function(llama, state)
	llama:setSequence( state )
	llama:play()
end



llama.sprite = graphics.newImageSheet("images/cabrawalk.png",objectSheet:getSheet())

llama.newCabraWalk = display.newSprite(llama.sprite,objectSheet:getSequenceData())
--llama.newCabraWalk.x = display.contentWidth * 0.15
--llama.newCabraWalk.y = H/2 - 50
llama.newCabraWalk:setSequence("fall")
llama.newCabraWalk:play()


return llama