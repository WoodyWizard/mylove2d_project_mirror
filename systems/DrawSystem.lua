local HooECS = require('HooECS')
local anim8 = require('anim8')

local DrawSystem = class("DrawSystem", System)


function DrawSystem:requires()
    return { first = {"base", "draw"}, second = {"tilemap"}, c = {"camera"}, animated = {"base", "animation"}, weapon = {"hand"}, particles = {'particles'}}
end



function DrawSystem:draw()
    for _, cam in pairs(self.targets.c) do
	--local spritebatch = love.graphics.newSpriteBatch()
        local camera = cam:get("camera")
	local base_player = cam:get("base")
        camera.camera:attach()
            for _, entity in pairs(self.targets.second) do
                local tilemap = entity:get("tilemap")
                tilemap.sti:drawLayer(tilemap.sti.layers["ground"])
                tilemap.sti:drawLayer(tilemap.sti.layers["trees"])
                tilemap.sti:drawLayer(tilemap.sti.layers["wallsandcollide"])
            end
            for _, entity in pairs(self.targets.first) do
		local drawObjectPosition = entity:get("base")
		local spriteObject = entity:get("draw")
		if drawObjectPosition.x < base_player.x + screen_size_w/2 and drawObjectPosition.x > base_player.x - screen_size_w/2 and 
		   drawObjectPosition.y < base_player.y + screen_size_h/2 and drawObjectPosition.y > base_player.y - screen_size_h/2 then
			love.graphics.draw(spriteObject.sprite, drawObjectPosition.x, drawObjectPosition.y, spriteObject.rotate ,spriteObject.scale)

		end
            end
            for _, animationEntity in pairs(self.targets.animated) do
                local position = animationEntity:get("base")
                local animation = animationEntity:get("animation")
		if position.x < base_player.x + screen_size_w/2 and position.x > base_player.x - screen_size_w/2 and 
		   position.y < base_player.y + screen_size_h/2 and position.y > base_player.y - screen_size_h/2 then
			animation.animation.current:draw(animation.spritesheet, position.x, position.y, animation.rotate , animation.scale)
		end
            end
	    for _, Hand in pairs(self.targets.weapon) do
		local h = Hand:get("hand")
		love.graphics.draw(h.sprite, h.x, h.y, 0, 0.3)
	    end
	    for _, part in pairs(self.targets.particles) do
        	local base = part:get('base')
        	local pa = part:get('particles')
		if base.x < base_player.x + screen_size_w/2 and base.x > base_player.x - screen_size_w/2 and 
		   base.y < base_player.y + screen_size_h/2 and base.y > base_player.y - screen_size_h/2 then
        		love.graphics.draw(pa.engine, base.x, base.y)
		end
	    end
        camera.camera:detach()
    end
end

return DrawSystem
