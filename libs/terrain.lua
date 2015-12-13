local physics = require( "physics" )
local Utils = require "libs.utils"
local terrain= {}

terrain.dimensions = {
	{145,415},
	{144,378},
	{144,330},
	{144,279},
	{144,224},
	{144,188},
	{144,138},
	{210,416},
	{210,390},
	{210,354},
	{210,309},
	{210,253},
	{210,226},
	{210,187},
	{210,134},
	{367,416},
	{367,388},
	{367,354},
	{367,324},
	{367,274},
	{367,228},
	{367,185},

}

terrain.newTerrain = function(group, lastX, index)
	local gaps = math.random(0,3000)
	local t
	if index and index == 1 then 
		gaps = 1500 
	end

	if gaps > 800 then
		local terrain_num = math.random( 1,22 )
		if index and index == 1 then 
			terrain_num = 1 
		end
		local dim = terrain.dimensions[terrain_num]
		t = display.newImageRect( group, "images/l_piso" .. terrain_num .. ".png", dim[1], dim[2] )
		t.x = lastX -3
		t.y = display.contentHeight + 50
		t.anchorX, t.anchorY = 0, 1
		local hW = t.width/2 
		local hH = t.height/2 
		physics.addBody( t, "kinematic", {shape={hW,hH,hW,hH * -1, hW * -1, hH * -1 + 30, hW* -1, hH * -1, hW * -1, hH}} )
		t.isSleepingAllowed = false
		t.objType = "ground"

	else
		--CREATE GAP
		t = display.newRect( group, lastX, display.contentHeight, gaps, 20 )
		physics.addBody( t, "kinematic", {isSensor=true} )
		t.anchorX = 0.5
		t.alpha = 0
		t.objType = "gap"
	end

	return t
end


return terrain