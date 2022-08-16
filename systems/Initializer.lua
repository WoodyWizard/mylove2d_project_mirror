local HooECS = require('HooECS')

local initializer = class("initializer", System)


function initializer:requires()
	return {object = {"collision"}, world = {"collisionworld"}}
end



function initializer:onAddEntity(entity)
	--print("created entity with collision ", entity)
	if entity:has("collision") == true then
		for _, obj in pairs(self.targets.world) do
			local world = obj:get("collisionworld")
			local basebase = entity:get("base")
			world.world:add(entity, basebase.x, basebase.y, basebase.width, basebase.height)
			entity:setParent(obj)
		end
	end
end

return initializer



