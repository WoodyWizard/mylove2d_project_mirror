local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local object = Component.create("object", {"id"}, {id = nil})


return object


