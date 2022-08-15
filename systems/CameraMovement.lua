local HooECS = require('HooECS')


local CameraMovement = class("CameraMovement", System)


function CameraMovement:requires()
        return {"base", "camera"}
end



function CameraMovement:update()
        for _, entity in pairs(self.targets) do
                local position = entity:get("base")
                local camera = entity:get("camera")
		camera.mouse_x, camera.mouse_y = camera.camera:mousePosition()
                camera.camera:lookAt(position.x + 32, position.y + 64)
        end
end

return CameraMovement

