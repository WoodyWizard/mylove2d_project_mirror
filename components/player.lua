local HooECS = require('HooECS')


local player = Component.create("player", {"id", "inventory", "hotbar"}, { id = 0, inventory = { size = 32, cells={} }, hotbar = { size=8, cells={} } })


return player
