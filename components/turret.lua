local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local turret = Component.create("turret", {"range", "arc", "angle", "reload", "segments", "rotation", "type", "target", "timer", "distance"}, {range=300, angle = 1, arc=360, reload=1, segments=1, rotation=1, type='default', target=nil, timer=0, distance = 0})


return turret


