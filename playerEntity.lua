local entityCore = require("entity")
local CORE_CORE = require('core')

local player = {entity = nil, faceangle = 0, sprite = nil}



function player:new()
    local playerObject = deepcopy(player)
    playerObject.entity = entityCore:new()
    return playerObject
end

function player:move(x,y)
    self.entity.position.x = self.entity.position.x + x
    self.entity.position.y = self.entity.position.y + y
end

function player:movement()
    local dx, dy = 0,0
    if love.keyboard.isDown("w") then
            dy = dy + -(self.entity.velocity)
    end
    if love.keyboard.isDown("s") then
            dy = dy +  (self.entity.velocity)
    end
    if love.keyboard.isDown("a") then
            dx = dx + -(self.entity.velocity)
    end
    if love.keyboard.isDown("d") then
            dx = dx +  (self.entity.velocity)
    end
    

    if CORE_CORE.list_collision ~= nil then
        local copy_positionX, copy_positionY  = self.entity.position.x, self.entity.position.y
        for i = 1, #CORE_CORE.list_collision, 1 do
            copy_positionX = copy_positionX + dx
            if CORE_CORE.list_collision[i]:detect_collision_cord(copy_positionX, copy_positionY, self.entity.collision_box.width, self.entity.collision_box.height) == true then
                copy_positionX = copy_positionX - dx
                dx = 0
            end
            copy_positionY = copy_positionY + dy
            if CORE_CORE.list_collision[i]:detect_collision_cord(copy_positionX, copy_positionY, self.entity.collision_box.width, self.entity.collision_box.height) == true then
                copy_positionY = copy_positionY - dy
                dy = 0
            end
        end
    end




    self:move(dx,dy)
end



return player