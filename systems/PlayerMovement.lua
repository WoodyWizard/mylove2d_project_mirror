local HooECS = require('HooECS')


local PlayerMovement = class("PlayerMovement", System)


function PlayerMovement:requires()
        return {"base", "velocity", "player", "animation", "camera"}
end



function PlayerMovement:update(dt)
        for _, entity in pairs(self.targets) do
                local position = entity:get("base")
                local velocity = entity:get("velocity")
                local animation = entity:get("animation")
                local collisionWorld = entity:getParent()
                local world = collisionWorld:get("collisionworld")

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

                local newPositionX, newPositionY = position.x + (dx * dt) , position.y + (dy * dt)
                --print(collisionWorld:get("collisionworld"))
                local actualX, actualY, cols, len = world.world:move(entity, newPositionX , newPositionY)
                position.x = actualX
                position.y = actualY
                --position.x = position.x + (dx * dt)
                --position.y = position.y + (dy * dt)
        end
end

return PlayerMovement

