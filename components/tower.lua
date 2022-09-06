local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local tower = Component.create("tower", {"gain", "timer", "reload"}, {gain = 8, timer = 0, reload = 1})


return tower


