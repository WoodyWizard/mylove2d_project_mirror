local HooECS = require('HooECS')


local CameraMovement = class("CameraMovement", System)


function CameraMovement:requires()
        return {"base", "camera"}
end



function CameraMovement:update(dt)
        for _, entity in pairs(self.targets) do
                local position = entity:get("base")
                local camera = entity:get("camera")

                camera.camera:lookAt(position.x + 32, position.y + 64)
        end
end

return CameraMovement

