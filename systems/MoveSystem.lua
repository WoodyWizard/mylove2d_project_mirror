local HooECS = require('HooECS')

local bulletFilter = function(item,other)
	local object = other:get('collision')
	local team = other:get('team')
	local team_item = item:get('team')

	if object.collision_type == 'wall' then return 'touch'
	elseif team.team == team_item.team then return nil
	elseif object.collision_type == 'player' then return 'touch'
	elseif object.collision_type == 'bullet' then return nil
	elseif object.collision_type == 'turret' and team.team ~= team_item.team then return 'touch'  
	else return nil
	end
end


local MoveSystem = class("MoveSystem", System)


function MoveSystem:requires()
    return {"base", "velocity", "bullets", "collision", "bulletfilter"}
end



function MoveSystem:update(dt)
    for _, entity in pairs(self.targets) do
	local collisionworld = entity:getParent()
	local world = collisionworld:get("collisionworld")
	local position = entity:get("base")
        local velocity = entity:get("velocity")
	local bullet = entity:get("bullets")

	local pos1x = position.x + math.sin(bullet.angle) * velocity.dx * dt
	local pos1y = position.y + math.cos(bullet.angle) * velocity.dy * dt
	local actualX, actualY, cols, len = world.world:move(entity, pos1x, pos1y, bulletFilter)
        position.x = actualX 
        position.y = actualY
	for i=1, len do
		local other = cols[i].other:get('collision')
		if other.collision_type == 'wall' or other.collision_type == 'turret' or other.collision_type == 'player' then
			local eng = cols[i].item:getEngine()
			world.world:remove(cols[i].item)
			eng:removeEntity(cols[i].item)
		end
	end
    end
end

return MoveSystem
