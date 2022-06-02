local entityCore = require("entity")
local CORE_CORE = require('core')

local player = {entity = nil, faceangle = 0, sprite = nil, anim = nil, animation = {}}



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
    self.anim = self.animation.default
    local dx, dy = 0,0
    if love.keyboard.isDown("w") then
            dy = dy + -(self.entity.velocity)
            self.anim = self.animation.up
    end
    if love.keyboard.isDown("s") then
            dy = dy +  (self.entity.velocity)
            self.anim = self.animation.down
    end
    if love.keyboard.isDown("a") then
            dx = dx + -(self.entity.velocity)
            self.anim = self.animation.left
    end
    if love.keyboard.isDown("d") then
            dx = dx +  (self.entity.velocity)
            self.anim = self.animation.right
    end
    

    if CORE_CORE.list_collision ~= nil then
        local copy_positionX, copy_positionY  = self.entity.position.x, self.entity.position.y
        copy_positionX = copy_positionX + dx 
        for i = 1, #CORE_CORE.list_collision, 1 do
            if CORE_CORE.list_collision[i]:detect_collision_cord(copy_positionX, copy_positionY, self.entity.collision_box.width, self.entity.collision_box.height, self) == true then
                copy_positionX = copy_positionX - dx
                dx = 0
            end
        end
        copy_positionY = copy_positionY + dy
        for i = 1, #CORE_CORE.list_collision, 1 do  
            if CORE_CORE.list_collision[i]:detect_collision_cord(copy_positionX, copy_positionY, self.entity.collision_box.width, self.entity.collision_box.height, self) == true then
                copy_positionY = copy_positionY - dy
                dy = 0
            end
        end

    end



    
    self:move(dx,dy)
end



return player