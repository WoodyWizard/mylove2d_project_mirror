local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local turret = Component.create("turret", {"range", "arc", "angle", "reload", "segments", "rotation", "type", "target"}, {range=15, angle = 1, arc=360, reload=1, segments=1, rotation=1, type='default', target=nil})


return turret


