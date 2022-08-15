local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local hand = Component.create("hand", {"x", "y", "sprite", "angle" , "width", "height"}, {x = 0, y = 0, sprite=nil ,angle=0, width = 16, height = 16})


return hand


