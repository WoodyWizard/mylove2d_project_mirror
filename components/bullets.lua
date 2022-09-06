local HooECS = require('HooECS')


local bullets = Component.create("bullets", {"angle", "parent"}, {angle = 0, parent = nil})


return bullets

