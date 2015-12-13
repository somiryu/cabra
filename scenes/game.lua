-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )
local scoreM = require("libs.score")

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
local score
local scoreLabel
local powerUp

physics.start()
physics.setGravity( 0, 30)
--physics.setDrawMode( "hybrid" )





function scene:create( event )
	local sceneGroup = self.view

	collisionListener = function(e)
	
	if e.phase == "began" then
			print("COLLISION")
			if e.other.objType == "ground" then
				print("Setting to 1")
				self.llama.canJump = 1
				print("TOUCHING GROUND: ".. self.llama.canJump)
				if e.target.state ~= "stand by" then 
					llama.changeSprite(e.target, "walk")
					self.llama.state = "grounded"
				else
					llama.changeSprite(e.target, "standby")
				end
				e.target:setLinearVelocity( 0, 0 )

			end
		end
	end

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
					local highScore = scoreM.getPlayerScore(score)
					local highScoreLabel = display.newText( sceneGroup, "HIGHSCORE: "..highScore, display.contentCenterX, 
						gameOver.y+220, "Arial", 50 )

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
					score = score + 1
					scoreLabel.text = score
					powerUp:toFront()
				end

				local xAbsPos, yAbsPos = ceilings[1]:localToContent(0,0)
				if xAbsPos < display.contentWidth * 0.25 * -1 then
					ceilings[1]:removeSelf( )
					table.remove(ceilings, 1)
					table.insert(ceilings, ceiling.newCeiling(self.terrains, ceilings[#ceilings].x + ceilings[#ceilings].width))
					scoreLabel:toFront( )

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

				--[[
				if yAccel > 0 and self.llama.state == "grounded" then
					llama.changeSprite(self.llama, "fall")
      				self.llama.state = "falling"
      				print("Setting to 2 in ACCEL")
      				self.llama.canJump = 2
				end]]

				if yAccel > 300 and self.llama.state == "falling" then
					llama.changeSprite(self.llama, "freefall")
      				self.llama.state = "free falling"
				end
			end

			self.animation = timer.performWithDelay(1, moveBg, -1 )
		end

	end

	local function holdTimer(e)
		forceApplied = forceApplied - 10000
	end

	local function jumpLlama(e)
		print("INIT CAN JUMP: "..self.llama.canJump)
		if e.phase == "began" then
			print("BEGAN CAN JUMP:" .. self.llama.canJump)
			Runtime:addEventListener("enterFrame", holdTimer)
		elseif e.phase == "ended" then
			local force = forceApplied
			Runtime:removeEventListener( "enterFrame", holdTimer)
			--forceApplied = -10000
			print("CAN JUMP BEFORE:" .. self.llama.canJump)
			if ( self.llama.canJump == 3 ) then
      		--jump procedure here
      			print("QUICK FALL")
      			llama.changeSprite(self.llama, "hitwall")
      			self.llama.state = "rush_down"
      			print("Setting to 0")
      			self.llama.canJump = 0
      			self.llama:applyForce( 0, 100000)
   			end

			if ( self.llama.canJump == 2 ) then
      		--jump procedure here
      			print("JUMP 2")
      			llama.changeSprite(self.llama, "jump")
      			self.llama.state = "raising"
      			print("Setting to 3")
      			self.llama.canJump = 3
      			if force < -120000 then force = -120000 end
      			self.llama:setLinearVelocity( 0, 0 )
      			self.llama:applyForce( 0, force, self.llama.x, self.llama.y)
   			end
			if ( self.llama.canJump == 1 ) then
      			--jump procedure here
      			print("JUMP 1")
      			llama.changeSprite(self.llama, "jump")
      			self.llama.state = "raising"
      			print("Setting to 2")
      			self.llama.canJump = 2
      			print(force)
      			if force < -100000 then force = -100000 end
      			print(force)
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
	
	score = 0
	scoreLabel = display.newText( sceneGroup, score, display.contentWidth - 80, 40, "Arial", 120 )
	scoreLabel.anchorX, scoreLabel.anchorY = 1, 0

	--powerUp Test
	local function activatePower(e)
		if e.phase == "began" then
			print("YES")
		local power = e.target
		if power.active == false then
			print("ACTIVATING")
			power.active = true
			terrainSpeed = terrainSpeed * 1.3
			ceilingSpeed = terrainSpeed * 1.3
			self.llama:setLinearVelocity( 0, 0 )
			self.llama.bodyType = "kinematic"


			local function stopPower(e)
				local function activateBotton(e)
					power.active = false
				end

				timer.performWithDelay( 2000, activateBotton )
				terrainSpeed = -800
				ceilingSpeed = -350
				self.llama.bodyType = "dynamic"
			end

			timer.performWithDelay( 500, stopPower, 1 )
		end
		end
		return true
	end

	powerUp = display.newRect( sceneGroup, display.contentWidth - 20, display.contentHeight-20, 150, 150 )
	powerUp.active = false
	powerUp.anchorX, powerUp.anchorY = 1, 1
	powerUp:addEventListener( 'touch', activatePower )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		score = 0
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
		scoreLabel:toFront()
		powerUp:toFront()
		-- CREATE A NE LLAMA
		self.llama = llama.new(sceneGroup)
		self.llama:addEventListener( "collision", collisionListener )


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