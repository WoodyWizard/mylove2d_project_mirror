local HooECS = require('HooECS')


local draw = Component.create("draw", {"sprite", "scale", "rotate", "sy", "ox", "oy", "kx", "ky"}, {scale = 1, rotate = 0, sprite = nil, sy=scale, ox=0, oy=0, kx=0, ky=0})


return draw
