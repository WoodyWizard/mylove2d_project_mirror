local core = {list_collision = {}, list_draw = {}}


function core:add_collision(collision_box)
    table.insert(self.list_collision, collision_box)
end

function core:add_drawable(drawable)
    table.insert(self.list_draw, drawable)
end




return core