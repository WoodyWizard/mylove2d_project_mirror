local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local team = Component.create("team", {"team"}, {team='default'})


return team


