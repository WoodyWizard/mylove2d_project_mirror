local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local base = Component.create("base", {"x", "y", "width", "height", "tile_x", "tile_y", "moved"}, {x = 0, y = 0, width = 64, height = 64, tile_x = 0, tile_y = 0, moved = 0})


return base

