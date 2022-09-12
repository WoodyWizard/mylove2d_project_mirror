local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local tower = Component.create("tower", {"gain", "timer", "reload", "owner", "capture_timer"}, {gain = 8, timer = 0, reload = 1, owner = nil, capture_timer=0})


return tower


