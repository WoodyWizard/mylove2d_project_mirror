local HooECS = require('HooECS')


local TowerSystem = class("TowerSystem", System)


function TowerSystem:requires()
        return {t = {"tower"}, players = {"player", "object"}}
end



function TowerSystem:update(dt)
	for _, entity in pairs(self.targets.t) do
		local tower = entity:get("tower")
		local tower_base = entity:get("base")
		for _, value in pairs(self.targets.players) do
			local player_base = value:get("base")
			if tower.owner ~= value then
				if math.dist(tower_base.x, tower_base.y, player_base.x, player_base.y) < 500 then
					local reload_timer = love.timer.getTime()
					if tower.capture_timer + 10 < reload_timer then
						tower.owner = value
						print("tower captured")
						trumpet:play()
						tower.capture_timer = love.timer.getTime()
					end
				else
					tower.capture_timer = love.timer.getTime()
				end
			end
		end
		local player_resources = nil
		if tower.owner ~= nil then
			player_resources = tower.owner:get("resources")
		end

		local reload_timer = love.timer.getTime()
		if tower.timer + tower.reload < reload_timer then
			if player_resources ~= nil then
			player_resources.money = player_resources.money + tower.gain
			end
			tower.timer = love.timer.getTime()
		end
        end
end




return TowerSystem





