local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local bulletfilter = Component.create("bulletfilter", {"objects"}, {objects=nil})


return bulletfilter


