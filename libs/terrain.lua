local physics = require( "physics" )
local Utils = require "libs.utils"
local terrain= {}

terrain.dimensions = {
	{105,415},
	{104,378},
	{104,330},
	{104,279},
	{104,224},
	{104,188},
	{104,138}
}

terrain.newTerrain = function(group, lastX, index)
	local gaps = math.random(0,2500)
	local t
	print("CREATING")
	if index and index == 1 then 
		print("FIRST")
		gaps = 1500 
	end

	if gaps > 800 then

		local terrain_num = math.random( 1,7 )
		local dim = terrain.dimensions[terrain_num]
		t = display.newImageRect( group, "images/l_piso" .. terrain_num .. ".png", dim[1], dim[2] )
		t.x = lastX
		t.y = display.contentHeight
		t.anchorX, t.anchorY = 0, 1
		local hW = t.width/2 -5
		local hH = t.height/2 * -1 - 5
		physics.addBody( t, "kinematic" )
		t.isSleepingAllowed = false
		t.objType = "ground"

	else
		--CREATE GAP
		t = display.newRect( group, lastX, display.contentHeight, gaps, 20 )
		physics.addBody( t, "kinematic" )
		t.anchorX = 0
		t.alpha = 0
		t.objType = "gap"
	end

	return t
end


return terrain