local HooECS = require('HooECS')
local anim8 = require('anim8')


local UpdateAnimation = class("UpdateAnimation", System)


function UpdateAnimation:requires()
    return {"base", "animation"}
end


function UpdateAnimation:update(dt)
    for _, entity in pairs(self.targets) do
        local animation = entity:get("animation")
        animation.animation.current:update(dt)
    end
end


return UpdateAnimation