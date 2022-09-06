local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local weapon = Component.create("weapon", {"timer", "reload", "type"}, {timer = 0, reload = 1, type = 1})


return weapon


