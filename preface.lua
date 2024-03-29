local HooECS = require('HooECS')

local my_components = require('components')
local MoveSystem = require('systems.MoveSystem')
local PlayerMovement = require('systems.PlayerMovement')
local DrawSystem = require('systems.DrawSystem')
local AnimationSystem = require('systems.AnimationSystem')
local UpdateAnimation = require('systems.UpdateAnimation')
local CameraMovement = require('systems.CameraMovement')
local CollisiomSystem = require('systems.CollisionSystem')
local TileMapSystem = require('systems.TileSystem')
local BulletSystem = require('systems.BulletSystem')
local HandMovement = require('systems.HandMovement')
local MouseMovement = require('systems.MouseMovement')
local CollisionInitializer = require('systems.Initializer')
local TurretControl = require('systems.TurretControl')
local HpSystem = require('systems.HpSystem')
local DrawParticles = require('systems.DrawParticles')
local UpdateParticles = require('systems.UpdateParticles')
local PlayerInventory = require('systems.PlayerInventory')


local preface = {systems = {MoveSystem = MoveSystem, PlayerMovement = PlayerMovement, DrawSystem = DrawSystem, AnimationSystem = AnimationSystem,
                UpdateAnimation = UpdateAnimation, CameraMovement = CameraMovement, CollisiomSystem = CollisiomSystem, TileMapSystem = TileMapSystem, BulletSystem = BulletSystem, HandMovement = HandMovement, MouseMovement = MouseMovement, CollisionInitializer = CollisionInitializer, TurretControl = TurretControl, HpSystem = HpSystem, DrawParticles = DrawParticles, UpdateParticles = UpdateParticles, PlayerInventory = PlayerInventory}}


function preface:entity_component(name, values)
    local entity = Entity()
    entity:initialize()
    entity:add(my_components:add(name)(values))
    return entity
end


function preface:add_component(name)
    return my_components:add(name)
end


return preface
