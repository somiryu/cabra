local physics = require( "physics" )
local Utils = require "libs.utils"
local objectSheet = require("libs.cabrawalk")

local llama= {}

collisionListener = function(e)
	
	if e.phase == "began" then
		print("COLLISION")
		print(e.target.canJump)
		e.target:setLinearVelocity( 0, 0 )
		e.target.canJump = 1
		Utils.print_r(e.target.canJump)
	end
end

llama.new = function(group)
	local llama = llama.newCabraWalk
	llama.width = 100
	llama.height = 100
	physics.addBody( llama, { density=8, friction=0, bounce=0 })
	llama.isFixedRotation = true
	llama.canJump = 1
	llama.isSleepingAllowed = false
	llama:addEventListener( "collision", collisionListener )

	return llama
end


local W = display.contentWidth
local H = display.contentHeight


llama.sprite = graphics.newImageSheet("images/cabrawalk.png",objectSheet:getSheet())

llama.newCabraWalk = display.newSprite(llama.sprite,objectSheet:getSequenceData())
llama.newCabraWalk.x = display.contentWidth * 0.15
llama.newCabraWalk.y = H/2 - 50
llama.newCabraWalk:setSequence("walk")
llama.newCabraWalk:play()

llama.changeState = function(e)

llama.newCabraJump = display.newSprite(llama.sprite,objectSheet:getSequenceData())
llama.newCabraJump.x = W/2 -300
llama.newCabraJump.y = H/2
llama.newCabraJump:setSequence("jump")
llama.newCabraJump:play()

llama.newCabraFall = display.newSprite(llama.sprite,objectSheet:getSequenceData())
llama.newCabraFall.x = W/2 
llama.newCabraFall.y = H/2
llama.newCabraFall:setSequence("fall")
llama.newCabraFall:play()

llama.newCabraFreefall = display.newSprite(llama.sprite,objectSheet:getSequenceData())
llama.newCabraFreefall.x = W/2 +300
llama.newCabraFreefall.y = H/2
llama.newCabraFreefall:setSequence("freefall")
llama.newCabraFreefall:play()
end

return llama