local HooECS = require('HooECS')


local TileSystem = class("TileSystem", System)


function TileSystem:requires()
    return {"tilemap"}
end



function TileSystem:update(dt)
    for _, entity in pairs(self.targets) do

    end
end

return TileSystem