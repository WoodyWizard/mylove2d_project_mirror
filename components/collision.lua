local HooECS = require('HooECS')


local collisio = Component.create("collision", {"something", "collision_type"}, {something = nil, collision_type = 'default'})


return collisio

