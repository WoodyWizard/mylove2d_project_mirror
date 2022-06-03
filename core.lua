local entityCreator = require('entity')
local arrowImage = love.graphics.newImage("arrow.png")
local HooECS = require('HooECS')
local preface = require('preface')
local bump = require 'bump.bump'

local core = {list_collision = {}, list_draw = {}, collision_id_list = {
    262,263
    },
    entities = {},
    engine = nil,
    eventmanager = nil,
    systems = {}
}


function core:init()
    HooECS.initialize({globals = true, debug = true})
    self.engine = HooECS.Engine()
    self.eventmanager = HooECS.EventManager()
end


function core:create_entity(components)
    local entity = HooECS.Entity()
    for _, comp in pairs(components) do
        entity:add(comp)
    end
    
    if entity:has("collision") then
        local worldOfCollision = self.engine:getEntitiesWithComponent("collisionworld")
        local worldworld = worldOfCollision[1]:get("collisionworld")
        local basebase = entity:get("base")
        worldworld.world:add(entity, basebase.x, basebase.y, basebase.width, basebase.height)
        entity:setParent(worldOfCollision[1])
    end

    self.engine:addEntity(entity)
end

function core:create_base_entity()
    local entity = preface:entity_component("base", {x = 100, y = 100})
    self.engine:addEntity(entity)
end


function core:add_component(name)
    return preface:add_component(name)
end


function core:init_collision()
    local world = bump.newWorld(64)
    self:create_entity({
        core:add_component("collisionworld")(world),
    })
end


function core:init_tilemap()
    local tiletile = self.engine:getEntitiesWithComponent("tilemap")
    local newsomething = tiletile[2]:get("tilemap")

    for i = 1, newsomething.sti.layers["wallsandcollide"].height, 1 do
        for b = 1, newsomething.sti.layers["wallsandcollide"].width, 1 do
            if newsomething.sti.layers["wallsandcollide"].data[b][i] ~= nil then
                for collision_id_counter = 1, #core.collision_id_list, 1 do
                    if newsomething.sti.layers["wallsandcollide"].data[b][i].gid == core.collision_id_list[collision_id_counter] then
                        core:create_entity({
                            core:add_component("base")((i*64)-64,(b*64)-64),
                            core:add_component("collision")()
                        })
                    end
                end
            end
        end
    end
end


function core:load_systems(dt)
    self.engine:addSystem(preface.systems.MoveSystem())
    self.engine:addSystem(preface.systems.PlayerMovement())
    self.engine:addSystem(preface.systems.DrawSystem(), "draw")
    --self.engine:addSystem(preface.systems.AnimationSystem(), "draw")
    self.engine:addSystem(preface.systems.UpdateAnimation())
    self.engine:addSystem(preface.systems.CameraMovement())
    self.engine:addSystem(preface.systems.CollisiomSystem())
end


function core:add_collision(collision_box)
    table.insert(self.list_collision, collision_box)
end

function core:add_drawable(drawable)
    if drawable.scale == nil then
        drawable.scale = 1
    end
    if drawable.rotate == nil then
        drawable.rotate = 0
    end
        table.insert(self.list_draw, drawable)
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
end



return core