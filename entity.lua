require("utils")

local entity = {position = {x = 0, y = 0}, collision_box = {width = 0, height = 0}, velocity = 0, image = nil}



function entity:new()
    local object = deepcopy(self)
    return object
end

function entity:set_velocity(velocity)
    self.velocity = velocity
end

function entity:load_image(image)
    self.image = image
end

function entity:set_position(x,y)
    self.position.x = x
    self.position.y = y
end

function entity:set_collision(w, h)
    self.collision_box.width = w
    self.collision_box.height = h
end

function entity:detect_collision(objectEntity)
    if objectEntity.position.x >= self.position.x or objectEntity.position.x + objectEntity.collision_box.width >= self.position.x  then
        if objectEntity.position.x <= self.position.x + self.collision_box.width then
            if objectEntity.position.y >= self.position.y or objectEntity.position.y + objectEntity.collision_box.height >= self.position.y then
                if objectEntity.position.y <= self.position.y + self.collision_box.height then
                    --print("collision")
                    return true
                end
            end
        end
    end
    return false
end

function entity:detect_collision_cord(x, y, w, h)
    if x >= self.position.x or x + w >= self.position.x  then
        if x <= self.position.x + self.collision_box.width then
            if y >= self.position.y or y + h >= self.position.y then
                if y <= self.position.y + self.collision_box.height then
                    --print("collision")
                    return true
                end
            end
        end
    end
    return false
end


function entity:corners(objectEntity)
    local xy_angles = {
        {x = objectEntity.position.x, y = objectEntity.position.y},
        {x = objectEntity.position.x + objectEntity.collision_box.width, y = objectEntity.position.y},
        {x = objectEntity.position.x, y = objectEntity.position.y + objectEntity.collision_box.height},
        {x = objectEntity.position.x + objectEntity.collision_box.width, y = objectEntity.position.y + objectEntity.collision_box.height},
    }
    return xy_angles
end



return entity