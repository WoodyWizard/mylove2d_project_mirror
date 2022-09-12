local HooECS = require('HooECS')
HooECS.initialize({globals = true, debug = true})


local resources = Component.create("resources", {"money", "energy", "gold", "steel", "hitech"}, {money = 0, energy = 0, gold = 0, steel = 0, hitech = 0})


return resources


