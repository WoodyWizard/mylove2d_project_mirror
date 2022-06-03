local HooECS = require('HooECS')


local MoveSystem = class("MoveSystem", System)


function MoveSystem:requires()
    return {"base", "velocity", "bullets"}
end



function MoveSystem:update(dt)
    for _, entity in pairs(self.targets) do
        --local position = entity:get("base")
        --local velocity = entity:get("velocity")
        --position.x = position.x + velocity.dx * dt
        --position.y = position.y + velocity.dy * dt
        print("MoveSystem")
    end
end

return MoveSystem