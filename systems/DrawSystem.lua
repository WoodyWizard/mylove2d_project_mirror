local HooECS = require('HooECS')
local anim8 = require('anim8')

local DrawSystem = class("DrawSystem", System)


function DrawSystem:requires()
    return { first = {"base", "draw"}, second = {"tilemap"}, c = {"camera"}, animated = {"base", "animation"}, weapon = {"hand"}, particles = {'particles'}, player = {'player'}}
end



function DrawSystem:draw()
    for _, cam in pairs(self.targets.c) do
	local spritebatch = love.graphics.newSpriteBatch(bullet_image)
        local camera = cam:get("camera")
	local base_player = cam:get("base")
        camera.camera:attach()
            for _, entity in pairs(self.targets.second) do
                local tilemap = entity:get("tilemap")
                tilemap.sti:drawLayer(tilemap.sti.layers["ground"])
                tilemap.sti:drawLayer(tilemap.sti.layers["trees"])
                tilemap.sti:drawLayer(tilemap.sti.layers["wallsandcollide"])
            end
            for _, animationEntity in pairs(self.targets.animated) do
                local position = animationEntity:get("base")
                local animation = animationEntity:get("animation")
		if position.x < base_player.x + screen_size_w/2 and position.x > base_player.x - screen_size_w/2 and 
		   position.y < base_player.y + screen_size_h/2 and position.y > base_player.y - screen_size_h/2 then
			animation.animation.current:draw(animation.spritesheet, position.x, position.y, animation.rotate , animation.scale)
		end
            end
            for _, entity in pairs(self.targets.first) do
		local drawObjectPosition = entity:get("base")
		local spriteObject = entity:get("draw")
		if drawObjectPosition.x < base_player.x + screen_size_w/2 and drawObjectPosition.x > base_player.x - screen_size_w/2 and 
		   drawObjectPosition.y < base_player.y + screen_size_h/2 and drawObjectPosition.y > base_player.y - screen_size_h/2 then
		   if entity:has("bullets") then
		   	spritebatch:add(drawObjectPosition.x, drawObjectPosition.y, spriteObject.rotate, spriteObject.scale)	
		   else
			love.graphics.draw(spriteObject.sprite, drawObjectPosition.x, drawObjectPosition.y, spriteObject.rotate ,spriteObject.scale, spriteObject.sy, spriteObject.ox, spriteObject.oy, spriteObject.kx, spriteObject.ky)
		   end
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
	   love.graphics.draw(spritebatch)
	   
        camera.camera:detach()
	love.graphics.setColor(love.math.colorFromBytes(232,239,225,255))
	love.graphics.rectangle('fill', 0,0, 1920, 25)
	love.graphics.setColor(love.math.colorFromBytes(0,0,0,255))
		for _, entity in pairs(self.targets.player) do 
			local res = entity:get("resources")
			love.graphics.print("Money: "..tostring(res.money), 10, 5)
			love.graphics.print("Energy: "..tostring(res.energy), 110, 5)
			love.graphics.print("Gold: "..tostring(res.gold), 210, 5)
			love.graphics.print("Steel: "..tostring(res.steel), 310, 5)
			love.graphics.print("HITech: "..tostring(res.hitech), 410, 5)
		end
	love.graphics.setColor(255, 255, 255)
    end
end

return DrawSystem
