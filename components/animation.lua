local HooECS = require('HooECS')
local anim8 = require('anim8')

local animation = Component.create("animation", {"spritesheet", "grid", "animation", "anim", "rotate", "scale"}, 
                {spritesheet = nil, grid = nil, animation = nil, anim = nil, rotate = 0, scale = 1})


return animation

