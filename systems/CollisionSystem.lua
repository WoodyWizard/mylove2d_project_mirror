local HooECS = require('HooECS')


local CollisionSystem = class("CollisionSystem", System)


function CollisionSystem:requires()
        return {"base", "collision"}
end



function CollisionSystem:update(dt)
        for _, entity in pairs(self.targets) do
                local position = entity:get("base")
                local worldCollision = entity:getParent()

                
        end
end

return CollisionSystem

