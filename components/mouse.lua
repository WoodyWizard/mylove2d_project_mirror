local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local base = Component.create("mouse", {"x", "y"}, {x = 0, y = 0})


return base


