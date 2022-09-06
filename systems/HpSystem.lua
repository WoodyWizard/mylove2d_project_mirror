local HooECS = require('HooECS')


local HpSystem = class("HpSystem", System)


function HpSystem:requires()
        return {"hp"}
end



function HpSystem:update(dt)
	--print("HP update")
	for _, entity in pairs(self.targets) do
        end
end

function HpSystem:draw(dt)
	--print("HP draw")
	for _, entity in pairs(self.targets) do
        end
end



return HpSystem




