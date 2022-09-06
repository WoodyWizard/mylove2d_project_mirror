local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local timer = Component.create("timer", {"timer", "reload"}, {timer = 0, reload = 1})


return timer


