local physics = require( "physics" )
local Utils = require "libs.utils"
local objectSheet = require("libs.cabrawalk")

local llama= {}



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