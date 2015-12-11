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
local game_ended = false
local scrollSpeed = -8
local index = 1
local forceApplied = -20000
local terrainSpeed = -800
local ceilingSpeed = -350

physics.start()
physics.setGravity( 0, 9)
--physics.setDrawMode( "hybrid" )




function scene:create( event )
	local sceneGroup = self.view

	function tapScreen(e)
		if game_active == false then
		-- Begin the game
			self.llama:play()

			local gameOver = function(e)
				timer.cancel( self.animation )
				for i =1, #terrains do
					terrains[i]:setLinearVelocity(0,0)
				end

				for i =1, #ceilings do
					ceilings[i]:setLinearVelocity(00,0)
				end

				local function showGameOver(e)
					print("happening")
					local gameOver = display.newImageRect( sceneGroup, "images/l_gameover.png", 661, 363 )
					gameOver.x = display.contentCenterX
					gameOver.y = display.contentHeight * 0.4
					gameOver.xScale = 0.01
					gameOver.yScale = 0.01

					local function restart(e)
						local currScene = composer.getSceneName( "current" )
						composer.removeScene( currScene )
						composer.gotoScene( currScene )
					end

					gameOver:addEventListener( "tap", restart )
					transition.to(gameOver, {time=800, xScale=1, yScale=1, transition=easing.outElastic})
				end
				timer.performWithDelay( 300, showGameOver, 1 )
			end
			
			local function moveBg(e)
				for i =1, #terrains do
					terrains[i]:setLinearVelocity(terrainSpeed,0)
				end

				for i =1, #ceilings do
					ceilings[i]:setLinearVelocity(ceilingSpeed,0)
				end

				game_active = true

				local xAbsPos, yAbsPos = terrains[1]:localToContent(0,0)
				if xAbsPos < display.contentWidth * 0.25 * -1 then
					terrains[1]:removeSelf( )
					table.remove(terrains, 1)
					table.insert(terrains, terrain.newTerrain(self.terrains, terrains[#terrains].x + terrains[#terrains].width))
				end

				local xAbsPos, yAbsPos = ceilings[1]:localToContent(0,0)
				if xAbsPos < display.contentWidth * 0.25 * -1 then
					ceilings[1]:removeSelf( )
					table.remove(ceilings, 1)
					table.insert(ceilings, ceiling.newCeiling(self.terrains, ceilings[#ceilings].x + ceilings[#ceilings].width))
				end

				--gameOver
				if self.llama.x < display.contentWidth * 0.15 or self.llama.y > display.contentHeight + 300 then
					if not game_ended then
						llama.changeSprite(self.llama, "hitwall")
      					self.llama.state = "dead"
						timer.performWithDelay( 1000, gameOver, 1 )
						game_ended = true
					end
				end

				--check llama accel
				local xAccel, yAccel = self.llama:getLinearVelocity( )
				if yAccel > 0 and self.llama.state == "raising" then
					llama.changeSprite(self.llama, "fall")
      				self.llama.state = "falling"
				end

				if yAccel > 0 and self.llama.state == "grounded" then
					llama.changeSprite(self.llama, "fall")
      				self.llama.state = "falling"
      				self.llama.canJump = 2
				end

				if yAccel > 300 and self.llama.state == "falling" then
					llama.changeSprite(self.llama, "freefall")
      				self.llama.state = "free falling"
				end
			end

			self.animation = timer.performWithDelay(1, moveBg, -1 )
		end

	end

	local function holdTimer(e)
		forceApplied = forceApplied - 5000
	end

	local function jumpLlama(e)
		if e.phase == "began" then
			Runtime:addEventListener("enterFrame", holdTimer)
		elseif e.phase == "ended" then
			local force = forceApplied
			Runtime:removeEventListener( "enterFrame", holdTimer)
			forceApplied = -2000
			if ( self.llama.canJump == 2 ) then
      		--jump procedure here
      			print("JUMP 2")
      			llama.changeSprite(self.llama, "jump")
      			self.llama.state = "raising"
      			self.llama.canJump = 0
      			self.llama:applyForce( 0, force, self.llama.x - 60000, self.llama.y)
   			end
			if ( self.llama.canJump == 1 ) then
      			--jump procedure here
      			print("JUMP 1")
      			llama.changeSprite(self.llama, "jump")
      			self.llama.state = "raising"
      			self.llama.canJump = self.llama.canJump + 1
      			self.llama:applyForce( 0, force, self.llama.x, self.llama.y)
   			end
		end

	end

	-- display a background image
	local bg = display.newImageRect( sceneGroup, "images/l_background.png", 1440, 900 )
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	bg:addEventListener( "tap", tapScreen )
	bg:addEventListener( "touch", jumpLlama )
	
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

		local lastX = initialPos - 80
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