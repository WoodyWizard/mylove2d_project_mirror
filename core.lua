local arrowImage = love.graphics.newImage("arrow.png")
local HooECS = require('HooECS')
local preface = require('preface')
local bump = require 'bump.bump'

local core = {collision_id_list = {
    262,263
    },
    entities = {},
    engine = nil,
    eventmanager = nil,
    systems = {}
}


function core:init(engine, eventmanager)
    HooECS.initialize({globals = true, debug = true})
    self.engine = engine
    self.eventmanager = eventmanager
end


function core:create_entity(components)
    local entity = HooECS.Entity()
    for _, comp in pairs(components) do
        entity:add(comp)
    end
    
    --if entity:has("collision") then
    --    local worldOfCollision = self.engine:getEntitiesWithComponent("collisionworld")
    --    local worldworld = worldOfCollision[1]:get("collisionworld")
    --    local basebase = entity:get("base")
    --    worldworld.world:add(entity, basebase.x, basebase.y, basebase.width, basebase.height)
    --    entity:setParent(worldOfCollision[1])
    --end
	
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
                            core:add_component("base")((i*64)-64,(b*64)-64, 64, 64, i, b),
                            core:add_component("collision")(nil, 'wall')
                        })
                    end
                end
            end
        end
    end
end


function core:load_systems(dt)
    self.engine:addSystem(preface.systems.CollisionInitializer())
    self.engine:addSystem(preface.systems.MoveSystem())
    self.engine:addSystem(preface.systems.PlayerMovement())
    self.engine:addSystem(preface.systems.CameraMovement())
    --self.engine:addSystem(preface.systems.TileMapSystem(), "draw")
    self.engine:addSystem(preface.systems.DrawSystem(), "draw")
    --self.engine:addSystem(preface.systems.AnimationSystem(), "draw")
    self.engine:addSystem(preface.systems.UpdateAnimation())
    self.engine:addSystem(preface.systems.CollisiomSystem())
    self.engine:addSystem(preface.systems.BulletSystem())
    self.engine:addSystem(preface.systems.HandMovement())
    self.engine:addSystem(preface.systems.MouseMovement())
    self.engine:addSystem(preface.systems.TurretControl())
    self.engine:addSystem(preface.systems.HpSystem(), "update")
    self.engine:addSystem(preface.systems.UpdateParticles())
    self.engine:addSystem(preface.systems.PlayerInventory())
    self.engine:addSystem(preface.systems.TowerSystem())
end


return core
