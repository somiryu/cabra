-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

initialPos = display.contentWidth * 0.25

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "scenes.game" )