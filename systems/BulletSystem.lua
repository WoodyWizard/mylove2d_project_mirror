local HooECS = require('HooECS')


local bulletsystem = class("bulletsystem", System)


function bulletsystem:requires()
        return {"base", "bullets", "collision"}
end



function bulletsystem:update(dt)

end

return bulletsystem 

