local HooECS = require('HooECS')

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

local turretcontrol = class("turretcontrol", System)


function turretcontrol:requires()
        return {t = {"turret"}, e = {"team", "object"}, walls = {"collision"}}
end



function turretcontrol:update(dt)
	for _, entity in pairs(self.targets.t) do
		local base = entity:get("base")
		local turret = entity:get("turret")
		local area = entity:get("area")
		local turret_team = entity:get("team")
		local turret_velocity = entity:get("velocity")
		for _, enemy in pairs(self.targets.e) do
			local enemy_base = enemy:get("base")
			local team = enemy:get("team")
			if math.dist(base.x, base.y, enemy_base.x, enemy_base.y) < turret.range and
			   team.team ~= turret_team.team then	

				turret.target = {x = enemy_base.x, y = enemy_base.y}
				local distx = enemy_base.x - base.x
				local disty = enemy_base.y - base.y

				local distance = math.min(math.sqrt(distx^2 + disty^2), 40)
				local angle = math.atan2(distx, disty)
				turret.angle = angle

				local fire_X = base.x +32 + (math.sin(angle) * distance)
				local fire_Y = base.y +32 + (math.cos(angle) * distance)
				--print("Turret attack range, attack point is : ", turret.target.x, " ", turret.target.y)

				--print(turret_team.team)

				if turret.type == 'simple' then
					local reload_timer = love.timer.getTime()
					if reload_timer < turret.timer + turret.reload then
					else
						local eng = entity:getEngine()
						local entity_bullet = HooECS.Entity(entity)
						local base_bullet = Component.create("base", {"x", "y", "width", "height"}, {x= fire_X, y=fire_Y, width = 8, height=8})
						local bullets = Component.create("bullets", {"angle"}, {angle = angle})
						local velocity = Component.create("velocity", {"dx", "dy"}, {dx = 1000, dy = 1000})
						local collisio = Component.create("collision", {"something", "collision_type"}, {something = nil, collision_type = 'bullet'})
						local draw = Component.create("draw", {"scale", "rotate", "sprite"}, {scale = 0.2, rotate = 0, sprite = nil})
						local bulletfilter = Component.create("bulletfilter",{"objects"}, {objects = nil})
						local teamteam = Component.create("team", {"team"}, {team = turret_team.team})

						entity_bullet:add(base_bullet())
						entity_bullet:add(bullets())
						entity_bullet:add(velocity(turret_velocity.dx, turret_velocity.dy))
						entity_bullet:add(collisio())
						entity_bullet:add(draw(0.1,0,bullet_image))
						entity_bullet:add(bulletfilter())
						entity_bullet:add(teamteam())
						--entity_bullet:setParent(entity)
						eng:addEntity(entity_bullet)

						turret.timer = love.timer.getTime()	
					end
				end
				if turret.type == 'shotgun' then
					local reload_timer = love.timer.getTime()
					if reload_timer < turret.timer + turret.reload then
					else
						for i = -0.4, 0.4, 0.4 do
							local eng = entity:getEngine()
							local entity_bullet = HooECS.Entity(entity)
							local base = Component.create("base", {"x", "y", "width", "height"}, {x= fire_X, y=fire_Y, width = 8, height=8})
							local bullets = Component.create("bullets", {"angle"}, {angle = angle + i})
							local velocity = Component.create("velocity", {"dx", "dy"}, {dx = 1000, dy = 1000})
							local collisio = Component.create("collision", {"something", "collision_type"}, {something = nil, collision_type = 'bullet'})
							local draw = Component.create("draw", {"scale", "rotate", "sprite"}, {scale = 0.2, rotate = 0, sprite = nil})
							local bulletfilter = Component.create("bulletfilter",{"objects"}, {objects = nil})
							local teamteam = Component.create("team", {"team"}, {team = turret_team.team})

							entity_bullet:add(base())
							entity_bullet:add(bullets())
							entity_bullet:add(velocity(turret_velocity.dx, turret_velocity.dy))
							entity_bullet:add(collisio())
							entity_bullet:add(draw(0.1,0,bullet_image))
							entity_bullet:add(bulletfilter())
							entity_bullet:add(teamteam())
							--entity_bullet:setParent(entity)
							eng:addEntity(entity_bullet)

							turret.timer = love.timer.getTime()	
						end
					end

				end
			end
		end
        end
end

return turretcontrol




