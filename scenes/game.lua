-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )

-- include Corona's "widget" library
local widget = require "widget"
local terrain = require "libs.terrain"
local ceiling = require "libs.ceilings"
local llama = require "libs.llama"
local Utils = require "libs.utils"

--------------------------------------------
local terrains = {}
local ceilings = {}
local game_active = false
local scrollSpeed = -8
local index = 1

physics.start()
physics.setGravity( 0, 9)
physics.setDrawMode( "hybrid" )




function scene:create( event )
	local sceneGroup = self.view

	function tapScreen(e)
		if game_active == false then
		-- Begin the game
			game_active = true
			local function moveBg(e)
				for i =1, #terrains do
					terrains[i]:setLinearVelocity(-500,0)
				end

				local xAbsPos, yAbsPos = terrains[1]:localToContent(0,0)
				print(xAbsPos)
				if xAbsPos < display.contentWidth * 0.25 * -1 then
						print("DOOOOONE")
						terrains[1]:removeSelf( )
						table.remove(terrains, 1)
						table.insert(terrains, terrain.newTerrain(self.terrains, terrains[#terrains].x + terrains[#terrains].width))
					end
			end

			print("TRYING")
			self.animation = Runtime:addEventListener("enterFrame", moveBg )

			--self.background_animation = timer.performWithDelay( 100, moveBg, -1 )
		end

		

		if ( self.llama.canJump == 2 ) then
      		--jump procedure here
      		self.llama.canJump = self.llama.canJump + 1
      		self.llama:applyForce( 0, -50000, self.llama.x, self.llama.y)
   		end
		if ( self.llama.canJump == 1 ) then
      		--jump procedure here
      		print("HERE")
      		self.llama.canJump = self.llama.canJump + 1
      		self.llama:applyForce( 0, -35000, self.llama.x, self.llama.y)
   		end
   		

	end

	-- display a background image
	local bg = display.newImageRect( sceneGroup, "images/l_background.png", 1440, 821 )
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	bg:addEventListener( "tap", tapScreen )
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		

		self.terrains = display.newGroup( )
		sceneGroup:insert(self.terrains)

		local lastX = display.contentWidth * 0.15 - 80
		local lastXC = -10
		for i = 1, 20 do
			terrains[i] = terrain.newTerrain(self.terrains, lastX, i)
			lastX = lastX + terrains[i].width
			ceilings[i] = ceiling.newCeiling(self.terrains, lastXC)
			lastXC = lastXC + ceilings[i].width
		end

		-- CREATE A NE LLAMA
		self.llama = llama.new(sceneGroup)
		


	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
		self.terrains:removeSelf( )
		self.terrains = nil
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene