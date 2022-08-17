local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local area = Component.create("area", {"width", "height", "collision", "x", "y"}, {width = 512, height = 512, collision=nil, x = 0, y = 0})


return area


