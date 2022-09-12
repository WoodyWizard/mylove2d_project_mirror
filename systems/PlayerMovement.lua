local HooECS = require('HooECS')


local TriggerPhantomEvent = class("TriggerPhantom")

function TriggerPhantomEvent:initialize(moved_object)
	self.object = moved_object
end




local playerFilter = function(item,other)
	local object = other:get('collision')
	if object.collision_type == 'wall' then return 'slide'
	elseif object.collision_type == 'turret' then return 'slide'
	elseif object.collision_type == 'bullet' then return nil
	else return nil
	end
end


local playermovement = class("playermovement", System)


function playermovement:requires()
        return {"base", "velocity", "player", "animation", "camera"}
end



function playermovement:update(dt)
        for _, entity in pairs(self.targets) do
                local position = entity:get("base")
                local velocity = entity:get("velocity")
                local animation = entity:get("animation")
                local collisionworld = entity:getParent()
                local world = collisionworld:get("collisionworld")

		animation.animation.current = animation.animation.default
                local dx , dy = 0, 0
                if love.keyboard.isScancodeDown("w") then
                        dy = dy + -(velocity.dy)*dt
                        animation.animation.current = animation.animation.up
                end
                if love.keyboard.isScancodeDown("s") then
                        dy = dy +  (velocity.dy)*dt
                        animation.animation.current = animation.animation.down
                end
                if love.keyboard.isScancodeDown("a") then
                        dx = dx + -(velocity.dx)*dt
                        animation.animation.current = animation.animation.left
                end
                if love.keyboard.isScancodeDown("d") then
                        dx = dx +  (velocity.dx)*dt
                        animation.animation.current = animation.animation.right
                end
		if position.tile_x ~= math.ceil((position.x+32)/64) then
			position.tile_x = math.ceil((position.x+32)/64)
			entity.eventManager:fireEvent(TriggerPhantomEvent(entity))
		end
		if position.tile_y ~= math.ceil((position.y+32)/64) then
			position.tile_y = math.ceil((position.y+32)/64)
			entity.eventManager:fireEvent(TriggerPhantomEvent(entity))
		end

                local newpositionx, newpositiony = position.x + dx , position.y + dy

                local actualx, actualy, cols, len = world.world:move(entity, newpositionx , newpositiony, playerFilter)
                position.x = actualx
                position.y = actualy
        end
end

return playermovement

