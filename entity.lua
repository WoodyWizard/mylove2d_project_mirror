require("utils")

local entity = {position = {x = 0, y = 0}, type = nil, collision_box = {width = 0, height = 0}, velocity = 0, image = nil, angle = nil, ignore_type = {}, id = {d = nil, c = nil, b = nil}}



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

function entity:set_scale(value)
    self.scale = value
end

function entity:set_rotate(value)
    self.rotate = value
end

function entity:set_angle(angle)
    self.angle = angle
end

function entity:set_type(type)
    self.type = type
end

function entity:set_ignore(ignore_type)
    table.insert(self.ignore_type, ignore_type)
end

function entity:check_ignore(object)
    for _, value in pairs(self.ignore_type) do
        if object.type == value then
            return true
        end
    end
    return false
end

function entity:set_id(d,c,b)
    if d ~= nil then
        self.id.d = d
    end
    if c ~= nil then
        self.id.c = c
    end
    if b ~= nil then
        self.id.b = b
    end
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

function entity:detect_collision_cord(x, y, w, h, player)
    if x - player.entity.velocity >= self.position.x  or x + w - player.entity.velocity >= self.position.x   then
        if x + player.entity.velocity  <= self.position.x + self.collision_box.width then
            if y >= self.position.y or y + h >= self.position.y then
                if y <= self.position.y + self.collision_box.height then
                    print("collision")
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