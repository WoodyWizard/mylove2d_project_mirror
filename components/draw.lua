local HooECS = require('HooECS')


local draw = Component.create("draw", {"scale", "rotate", "sprite"}, {scale = 1, rotate = 0, sprite = nil})


return draw
