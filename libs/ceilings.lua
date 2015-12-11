local physics = require( "physics" )

local ceilings= {}

ceilings.newCeiling = function(group, lastX)
	local width = math.random(150,250)
	local height = math.random(30,display.contentHeight * 0.2)
	local obj = display.newRect( group, lastX + width/2, 0, width, height )
	obj.y = obj.y + obj.height/2
	obj:setFillColor( 0.3,0.8,0.7 )
	physics.addBody( obj, "static")
	obj.objType = "ceiling"

	return obj
end


return ceilings