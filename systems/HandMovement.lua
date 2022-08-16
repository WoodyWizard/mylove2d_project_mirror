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

		local distx = camera.mouse_x - position.x
		local disty = camera.mouse_y - position.y

		local distance = math.min(math.sqrt(distx^2 + disty^2), 40)
		local angle = math.atan2(distx, disty)
		hand.angle = angle
		hand.x = position.x+8 + (math.sin(angle) * distance)
		hand.y = position.y+8 + (math.cos(angle) * distance)

		if love.mouse.isDown(1) == true then
			local eng = entity:getEngine()
			local entity_bullet = HooECS.Entity()
			local base = Component.create("base", {"x", "y", "width", "height"}, {x= hand.x, y=hand.y, width = 8, height=8})
			local bullets = Component.create("bullets", {"angle"}, {angle = hand.angle})
			local velocity = Component.create("velocity", {"dx", "dy"}, {dx = 0, dy = 0})
			local collisio = Component.create("collision", {"something", "collision_type"}, {something = nil, collision_type = 'bullet'})
			local draw = Component.create("draw", {"scale", "rotate", "sprite"}, {scale = 0.2, rotate = 0, sprite = nil})

			entity_bullet:add(base())
			entity_bullet:add(bullets())
			entity_bullet:add(velocity(1000,1000))
			entity_bullet:add(collisio())
			entity_bullet:add(draw(0.2,0,box_image))
			eng:addEntity(entity_bullet)
		end
        end
end

return handmovement


