local HooECS = require('HooECS')


local camera = Component.create("camera", {"camera", "mouse_x", "mouse_y"}, {mouse_x = 0, mouse_y = 0})


return camera

