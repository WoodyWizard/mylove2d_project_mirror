local HooECS = require('HooECS')

local handmovement = class("handmovement", System)


function handmovement:requires()
        return {Hand = {"base", "velocity", "player", "animation", "camera", "hand"}, Bullet_Creator = {"bullets", "velocity", "base"}}
end



function handmovement:update(dt)
        for _, entity in pairs(self.targets.Hand) do
		local position = entity:get("base")
		local camera = entity:get("camera")
		local hand = entity:get("hand")
		local team = entity:get("team")
		local weapon = entity:get("weapon")

		local distx = camera.mouse_x - position.x
		local disty = camera.mouse_y - position.y

		local distance = math.min(math.sqrt(distx^2 + disty^2), 40)
		local angle = math.atan2(distx, disty)
		hand.angle = angle
		hand.x = position.x+8 + (math.sin(angle) * distance)
		hand.y = position.y+8 + (math.cos(angle) * distance)

		if love.mouse.isDown(1) == true then
			--print(team.team)
			local reload_timer = love.timer.getTime()
			if reload_timer < weapon.timer + weapon.reload then
			else
				local eng = entity:getEngine()
				local entity_bullet = HooECS.Entity(entity)
				local base = Component.create("base", {"x", "y", "width", "height"}, {x= hand.x, y=hand.y, width = 8, height=8})
				local bullets = Component.create("bullets", {"angle"}, {angle = hand.angle})
				local velocity = Component.create("velocity", {"dx", "dy"}, {dx = 0, dy = 0})
				local collisio = Component.create("collision", {"something", "collision_type"}, {something = nil, collision_type = 'bullet'})
				local draw = Component.create("draw", {"scale", "rotate", "sprite"}, {scale = 0.2, rotate = 0, sprite = nil})
				local bulletfilter = Component.create("bulletfilter",{"objects"}, {objects = nil})
				local teamteam = Component.create("team", {"team"}, {team = team.team})
				entity_bullet:add(base())
				entity_bullet:add(bullets())
				entity_bullet:add(velocity(1000,1000))
				entity_bullet:add(collisio())
				entity_bullet:add(draw(0.1,0,bullet_image))
				entity_bullet:add(bulletfilter())
				entity_bullet:add(teamteam())
				--entity_bullet:setParent(entity)
				eng:addEntity(entity_bullet)
				love.audio.stop(shoot)
				love.audio.play(shoot)

				weapon.timer = love.timer.getTime()
			end
		end
        end
end

return handmovement


