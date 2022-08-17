local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local hp = Component.create("hp", {"health"}, {health=100})


return hp


