local HooECS = require('HooECS')
local anim8 = require('anim8')

local DrawSystem = class("DrawSystem", System)


function DrawSystem:requires()
    return { first = {"base", "draw"}, second = {"tilemap"}, c = {"camera"}, animated = {"base", "animation"}}
end



function DrawSystem:draw(dt)
    for _, cam in pairs(self.targets.c) do
        local camera = cam:get("camera")
        camera.camera:attach()

            for _, entity in pairs(self.targets.second) do
                local tilemap = entity:get("tilemap")
                tilemap.sti:drawLayer(tilemap.sti.layers["ground"])
                tilemap.sti:drawLayer(tilemap.sti.layers["trees"])
                tilemap.sti:drawLayer(tilemap.sti.layers["wallsandcollide"])
            end
            for _, entity in pairs(self.targets.first) do

            end
            for _, animationEntity in pairs(self.targets.animated) do
                local position = animationEntity:get("base")
                local animation = animationEntity:get("animation")
                animation.animation.current:draw(animation.spritesheet, position.x, position.y, animation.rotate , animation.scale)
            end
        camera.camera:detach()
    end
end

return DrawSystem