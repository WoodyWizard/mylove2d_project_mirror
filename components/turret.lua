local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local turret = Component.create("turret", {"range", "arc", "angle", "reload", "segments", "rotation", "type", "target", "timer", "distance", "phantom_timer", "switch"}, {range=300, angle = 1, arc=360, reload=1, segments=1, rotation=1, type='default', target={}, timer=0, distance = 0, phantom_timer=0, switch='off'})


return turret


