local entityCreator = require('entity')
local arrowImage = love.graphics.newImage("arrow.png")
local HooECS = require('HooECS')

local core = {list_collision = {}, list_draw = {}, collision_id_list = {
    262,263
    },
    bullets = {},
    gid = {d = 1, c = 1, b = 1},
    engine = nil,
    eventmanager = nil,

}


function core:init()
    HooECS.initialize()
    self.engine = HooECS.Engine()
    self.eventmanager = HooECS.EventManager()
end


function core:add_collision(collision_box)
    collision_box:set_id(nil,self.gid.c,nil)
    table.insert(self.list_collision, collision_box)
    self.gid.c = self.gid.c + 1
end

function core:add_drawable(drawable)
    if drawable.scale == nil then
        drawable.scale = 1
    end
    if drawable.rotate == nil then
        drawable.rotate = 0
    end
        drawable:set_id(self.gid.d,nil,nil)
        table.insert(self.list_draw, drawable)
        self.gid.d = self.gid.d + 1
end


function core:remove(object)
    table.remove(self.list_collision, object.id_c)
    table.remove(self.list_draw, object.id_d)
    table.remove(self.bullets, object.id_b)
    object = nil
    self.gid.d = self.gid.d - 1
    self.gid.c = self.gid.c - 1
    self.gid.b = self.gid.b - 1
end


function core:draw()
    if self.list_draw ~= nil then
        for i = 1, #self.list_draw, 1 do
            if self.list_draw[i].animation == nil then
                love.graphics.draw(self.list_draw[i].image,
                self.list_draw[i].position.x, self.list_draw[i].position.y , self.list_draw[i].rotate , self.list_draw[i].scale)
            else
                self.list_draw[i].animation:draw(self.list_draw[i].spritesheet, self.list_draw[i].position.x, self.list_draw[i].position.y, self.list_draw[i].rotate , self.list_draw[i].scale)
            end
        end
    end
    if self.bullets ~= nil then
        for i = 1, #self.bullets, 1 do
            if self.bullets[i] ~= nil then
                love.graphics.draw(self.bullets[i].image,
                self.bullets[i].position.x, self.bullets[i].position.y , self.bullets[i].rotate , self.bullets[i].scale)
            end
        end
    end
end


function core:find_delete(object)
    local dataObject = {id_c = nil, id_d = nil, id_b = nil}
    for key, value in pairs(self.list_collision) do
        if value == object then
            dataObject.id_c = key
        end
    end
    for key, value in pairs(self.list_draw) do
        if value == object then
            dataObject.id_d = key
        end
    end
    for key, value in pairs(self.bullets) do
        if value == object then
            dataObject.id_b = key
        end
    end
    return dataObject
end


function core:create_bullet(x,y,angl)
    local bullet = entityCreator:new()
    bullet:set_position(x,y)
    bullet:load_image(arrowImage)
    bullet:set_velocity(4000)
    bullet:set_collision(6,6)
    bullet:set_scale(0.1)
    bullet:set_angle(angl)
    bullet:set_type("bullet")
    bullet:set_ignore("bullet")
    bullet:set_ignore("box")
    bullet:set_id(nil,nil,self.gid.b)
    table.insert(self.bullets, bullet)
    core:add_drawable(bullet)
    core:add_collision(bullet)
    self.gid.b = self.gid.b + 1
end


function core:detect_bullet_collision()
    for key, value in pairs(self.bullets) do
        if value ~= nil then
            for _, blockOfCollision in pairs(self.list_collision) do
                if value ~= blockOfCollision then
                    if value ~= nil then
                        if value:detect_collision(blockOfCollision) == true then
                            if value:check_ignore(blockOfCollision) == false then
                                core:remove(core:find_delete(value))
                                value = nil
                            end
                        end
                    end
                end
            end
        end
    end
end





return core