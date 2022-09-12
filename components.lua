local HooECS = require('HooECS')
local base = require('components.base')
local velocity = require('components.velocity')
local draw = require('components.draw')
local animation = require('components.animation')
local player = require('components.player')
local bullets = require('components.bullets')
local camera = require('components.camera')
local collisionworld = require('components.collisionworld')
local collision = require('components.collision')
local tilemap = require('components.tilemap')
local hand = require('components.hand')
local mouse = require('components.mouse')
local turret = require('components.turret')
local team = require('components.team')
local area = require('components.area')
local hp = require('components.hp')
local bulletfilter = require('components.bulletfilter')
local object = require('components.object')
local weapon = require('components.weapon')
local tower = require('components.tower')
local resources = require('components.resources')

local components = { 
    base = base, 
    velocity = velocity,
    draw = draw,
    animation = animation,
    player = player,
    bullets = bullets,
    camera = camera,
    collisionworld = collisionworld,
    collision = collision,
    tilemap = tilemap,
    hand = hand,
    mouse = mouse,
    turret = turret,
    team = team,
    area = area,
    hp = hp,
    bulletfilter = bulletfilter,
    object = object,
    weapon = weapon,
    tower = tower,
    resources = resources
}


function components:add(name)
    return Component.all[name]
end



return components
