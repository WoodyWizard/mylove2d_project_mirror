local HooECS = require('HooECS')


local PhantomEvent = class("PhantomPlayerHit")

function PhantomEvent:initialize(turret_object)
	self.turret = turret_object
end



local bulletFilter = function(item,other)
	local object = other:get('collision')
	local team = other:get('team')
	local team_item = item:get('team')

	if object.collision_type == 'wall' then return 'touch'
	elseif team.team == team_item.team then return nil
	elseif object.collision_type == 'player' then return 'touch'
	elseif object.collision_type == 'bullet' then return nil
	elseif object.collision_type == 'turret' and team.team ~= team_item.team then return 'touch'  
	else return nil
	end
end


local MoveSystem = class("MoveSystem", System)


function MoveSystem:requires()
    return { default_bullets = {"base", "velocity", "bullets", "collision", "bulletfilter"}, phantom = {"phantom"}}
end



function MoveSystem:update(dt)
    for _, entity in pairs(self.targets.default_bullets) do
	local collisionworld = entity:getParent()
	local world = collisionworld:get("collisionworld")
	local position = entity:get("base")
        local velocity = entity:get("velocity")
	local bullet = entity:get("bullets")

	local pos1x = position.x + math.sin(bullet.angle) * velocity.dx * dt
	local pos1y = position.y + math.cos(bullet.angle) * velocity.dy * dt
	local actualX, actualY, cols, len = world.world:move(entity, pos1x, pos1y, bulletFilter)
        position.x = actualX 
        position.y = actualY
	for i=1, len do
		local other = cols[i].other:get('collision')
		local other_base = cols[i].item:get('base')
		if other.collision_type == 'wall' or other.collision_type == 'turret' or other.collision_type == 'player' then
			if entity:has("phantom") == false then
				local eng = cols[i].item:getEngine()
				local obj_partc = HooECS.Entity()
				local base = Component.create("base", {"x","y","width","height"}, {x=other_base.x, y=other_base.y, 64,64})

				local local_particle = love.graphics.newParticleSystem(PARTICLE, 128)
				local_particle:setParticleLifetime(0.5, 1) -- Particles live at least 2s and at most 5s.
				local_particle:setEmitterLifetime(0.1)
				local_particle:setEmissionRate(100)
				local_particle:setSizes(0.06)
				local_particle:setSpeed(40, 80)
				local_particle:setSpread(math.pi * 2)
				local_particle:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

				local particles = Component.create("particles", {"engine", "last_get_time"}, {engine = local_particle, last_get_time = love.timer.getTime()}) 

				obj_partc:add(base())
				obj_partc:add(particles())
				eng:addEntity(obj_partc)

				world.world:remove(cols[i].item)
				eng:removeEntity(cols[i].item)
			end
		else
				local eng = cols[i].item:getEngine()
				world.world:remove(cols[i].item)
				eng:removeEntity(cols[i].item)
		end
	end
    end
    for index, entity in pairs(self.targets.phantom) do 
	local collisionworld = entity:getParent()
	local world = collisionworld:get("collisionworld")
	local position = entity:get("base")
        local velocity = entity:get("velocity")
	local bullet = entity:get("bullets")

	local pos1x = position.x + math.sin(bullet.angle) * velocity.dx * dt
	local pos1y = position.y + math.cos(bullet.angle) * velocity.dy * dt
	local actualX, actualY, cols, len = world.world:move(entity, pos1x, pos1y, bulletFilter)
        position.x = actualX 
        position.y = actualY
	for i=1, len do
		local other = cols[i].other:get('collision')
		local other_base = cols[i].item:get('base')
		--print(other_base.x , " <- x | y -> ", other_base.y)
		if other.collision_type == 'player' then
			local eng = cols[i].item:getEngine()
			local base = Component.create("base", {"x","y","width","height"}, {x=other_base.x, y=other_base.y, 64,64})
			local evmanager = entity.eventManager
			local bullet_parent = bullet.bullet_parent
			local bullet_parent_turret = bullet_parent:get("turret")			
			bullet_parent_turret.switch = 'on'
		--	evmanager:fireEvent(PhantomEvent(bullet_parent))

			world.world:remove(cols[i].item)
			eng:removeEntity(cols[i].item)
			cols[i].item = nil
		else
			local bullet_parent = bullet.bullet_parent
			local bullet_parent_turret = bullet_parent:get("turret")
			bullet_parent_turret.switch = 'off'
			local eng = cols[i].item:getEngine()
			world.world:remove(cols[i].item)
			eng:removeEntity(cols[i].item)
			cols[i].item = nil
		end
	end


    end
end

return MoveSystem
