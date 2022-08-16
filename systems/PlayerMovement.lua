local HooECS = require('HooECS')

local playerFilter = function(item,other)
	local object = other:get('collision')
	if object.collision_type == 'wall' then return 'slide'
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
                if love.keyboard.isDown("w") then
                        dy = dy + -(velocity.dy)
                        animation.animation.current = animation.animation.up
                end
                if love.keyboard.isDown("s") then
                        dy = dy +  (velocity.dy)
                        animation.animation.current = animation.animation.down
                end
                if love.keyboard.isDown("a") then
                        dx = dx + -(velocity.dx)
                        animation.animation.current = animation.animation.left
                end
                if love.keyboard.isDown("d") then
                        dx = dx +  (velocity.dx)
                        animation.animation.current = animation.animation.right
                end


                local newpositionx, newpositiony = position.x + (dx * 0.016) , position.y + (dy * 0.016)

                --print(collisionworld:get("collisionworld"))
                local actualx, actualy, cols, len = world.world:move(entity, newpositionx , newpositiony, playerFilter)
                --print(actualx, " ", actualy)
                position.x = actualx
                position.y = actualy
                --position.x = position.x + (dx * dt)
                --position.y = position.y + (dy * dt)
        end
end

return playermovement

