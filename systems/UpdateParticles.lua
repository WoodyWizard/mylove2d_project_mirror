local HooECS = require('HooECS')


local UpdateParticles = class("UpdateParticles", System)


function UpdateParticles:requires()
        return {"particles"}
end



function UpdateParticles:update(dt)
	for _, entity in pairs(self.targets) do
		local eng = entity:getEngine()
		local part = entity:get('particles')
		part.engine:update(dt)
		local min_p, max_p = part.engine:getParticleLifetime()
		local lifetime = part.engine:getEmitterLifetime() + max_p
		--print("lifetime: ", lifetime)
		if lifetime > 0 then
			--print('lifetime: ', lifetime)
			local t = love.timer.getTime() - part.last_get_time
			if t > lifetime then
				part.engine:stop()
        			eng:removeEntity(entity)
				part.engine:release()
			end
		end
	end
end

return UpdateParticles



