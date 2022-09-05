local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local timer = Component.create("timer", {"timer"}, {timer = 0})


return timer


