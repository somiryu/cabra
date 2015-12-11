local physics = require( "physics" )

local ceilings= {}

ceilings.dimensions = {
	{234,216},
	{159,216},
	{259,171},
	{123,132},
	{130,131},
}

ceilings.newCeiling = function(group, lastX)

	local gaps = math.random(0,4500)
	local t
	if index and index == 1 then 
		gaps = 1500 
	end

	if gaps > 1500 then
		local terrain_num = math.random( 1,5 )
		local dim = ceilings.dimensions[terrain_num]
		obj = display.newImageRect( group, "images/l_techo" .. terrain_num .. ".png", dim[1], dim[2] )
		obj.anchorX, obj.anchorY = 0,0
		obj.x = lastX
		obj.y = -80
		physics.addBody( obj, "kinematic")
		obj.objType = "ceiling"
	else
		--CREATE GAP
		obj = display.newRect( group, lastX, 0, gaps, 20 )
		physics.addBody( obj, "kinematic", {isSensor=true} )
		obj.anchorX = 0.5
		obj.alpha = 0
		obj.objType = "gap"
	end

	return obj
end


return ceilings