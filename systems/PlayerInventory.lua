local HooECS = require('HooECS')




local playerinventory = class("playerinventory", System)


function playerinventory:requires()
        return {"player"}
end



function playerinventory:update(dt)
        for _, entity in pairs(self.targets) do

        end
end

function playerinventory:add(item)
	for _, entity in pairs(self.targets) do
		local inventory = entity:get("player")
		if #inventory.inventory.cells >= inventory.inventory.size then
			print("inventory full")
		else
			table.insert(inventory.inventory.cells, item)
		end
        end

end

return playerinventory


