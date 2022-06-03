local HooECS = require('HooECS')


local velocity = Component.create("velocity", {"dx", "dy"}, {dx = 0, dy = 0})


return velocity