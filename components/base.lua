local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local base = Component.create("base", {"x", "y", "width", "height"}, {x = 0, y = 0, width = 64, height = 64})


return base

