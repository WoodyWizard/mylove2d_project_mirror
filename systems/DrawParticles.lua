local HooECS = require('HooECS')


local DrawParticles = class("DrawParticles", System)


function DrawParticles:requires()
        return {"particles"}
end



function DrawParticles:draw(dt)
	for _, entity in pairs(self.targets) do

	end
end

return DrawParticles





