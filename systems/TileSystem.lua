local HooECS = require('HooECS')


local TileSystem = class("TileSystem", System)


function TileSystem:requires()
    return { tiles = {"tilemap"}, c = {"camera"} }
end



function TileSystem:draw(dt)

end

return TileSystem