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
    tilemap = tilemap
}


function components:add(name)
    return Component.all[name]
end



return components