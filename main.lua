-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local W = display.contentWidth
local H = display.contentHeight

local objectSheet = require("cabrawalk")
local myObjectSheet = graphics.newImageSheet("images/cabrawalk.png",objectSheet:getSheet())

local newCabraWalk = display.newSprite(myObjectSheet,objectSheet:getSequenceData())
newCabraWalk.x = W/2 -600
newCabraWalk.y = H/2
newCabraWalk:setSequence("walk")
newCabraWalk:play()

local newCabraJump = display.newSprite(myObjectSheet,objectSheet:getSequenceData())
newCabraJump.x = W/2 -300
newCabraJump.y = H/2
newCabraJump:setSequence("jump")
newCabraJump:play()

local newCabraFall = display.newSprite(myObjectSheet,objectSheet:getSequenceData())
newCabraFall.x = W/2 
newCabraFall.y = H/2
newCabraFall:setSequence("fall")
newCabraFall:play()

local newCabraFreefall = display.newSprite(myObjectSheet,objectSheet:getSequenceData())
newCabraFreefall.x = W/2 +300
newCabraFreefall.y = H/2
newCabraFreefall:setSequence("freefall")
newCabraFreefall:play()



-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "scenes.game" )