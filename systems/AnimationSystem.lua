local HooECS = require('HooECS')
local anim8 = require('anim8')


local AnimationSystem = class("AnimationSystem", System)


function AnimationSystem:requires()
    return {"base", "animation"}
end


function AnimationSystem:draw(dt)
    for _, entity in pairs(self.targets) do

    end
end

return AnimationSystem