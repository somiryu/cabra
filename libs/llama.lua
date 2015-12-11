local physics = require( "physics" )
local Utils = require "libs.utils"

local llama= {}

collisionListener = function(e)
	
	if e.phase == "began" then
		print(e.target.canJump)
		e.target:setLinearVelocity( 0, 0 )
		e.target.canJump = 1
		Utils.print_r(e.target.canJump)
	end
end

llama.new = function(group)
	local llama = display.newRect( group, display.contentWidth * 0.15, display.contentCenterY - 50, 100, 100 )
	llama:setFillColor( 0.2,0.2,0.2 )
	physics.addBody( llama, { density=9, friction=1.0, bounce=0 })
	llama.isFixedRotation = true
	llama.canJump = 1
	llama.isSleepingAllowed = false
	llama:addEventListener( "collision", collisionListener )

	return llama
end


return llama