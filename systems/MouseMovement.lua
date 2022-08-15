local HooECS = require('HooECS')


local mousemovement = class("mousemovement", System)


function mousemovement:requires()
        return {"mouse"}
end



function mousemovement:update(dt)
	for _, entity in pairs(self.targets) do
        end
end

return mousemovement



