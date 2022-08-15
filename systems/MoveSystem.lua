local HooECS = require('HooECS')


local MoveSystem = class("MoveSystem", System)


function MoveSystem:requires()
    return {"base", "velocity", "bullets"}
end



function MoveSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local position = entity:get("base")
        local velocity = entity:get("velocity")
	local bullet = entity:get("bullets")
        position.x = position.x + math.sin(bullet.angle) * velocity.dx * dt
        position.y = position.y + math.cos(bullet.angle) * velocity.dy * dt
    end
end

return MoveSystem
