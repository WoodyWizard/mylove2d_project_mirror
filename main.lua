local playerCore = require("playerEntity")
local entityCreator = require('entity')
local core = require('core')
local my_time = 0

local radiusup = 0

local player = playerCore:new()
--player.entity.position.x = 400
--player.entity.position.y = 400


local anglexxyy = 0.0
local localradius = 50

local loadingcircle = {}

local intersectionbox = {x = 0, y = 0, x2 = 0, y2 = 0}

function love.draw()
    cam:attach()
        love.graphics.push()
        --love.graphics.rectangle("fill", player.entity.position.x , player.entity.position.y  , 50,50)
        --love.graphics.polygon("fill", player.entity.position.x , 
        --                                player.entity.position.y - 25,
        --                                player.entity.position.x + 25, 
        --                                player.entity.position.y + 25, 
        --                                player.entity.position.x - 25, 
        --                                player.entity.position.y + 25)
        --love.graphics.line(player.entity.position.x + 25, player.entity.position.y + 25, player.entity.position.x + 25, player.entity.position.y + 125)
        --love.graphics.origin()

            love.graphics.draw(player.sprite,
            player.entity.position.x, player.entity.position.y)

        love.graphics.pop()

        local my_circle = {x = 500, y = 300, radius = 25}
        love.graphics.circle("line", my_circle.x, my_circle.y, my_circle.radius)
        local stringtest = string.format("radius: %u \ndiameter: %u", my_circle.radius, my_circle.radius*2)
        love.graphics.print(stringtest, my_circle.x, my_circle.y)

        local goqosi
            for i = 1, #loadingcircle, 1 do
                goqosi = string.format("sin: %f \ncos: %f\nangle: %f\nx: %f\ny: %f", math.sin(anglexxyy), math.cos(anglexxyy), anglexxyy , loadingcircle[#loadingcircle].x, loadingcircle[#loadingcircle].y)
                love.graphics.points(loadingcircle[i].x, loadingcircle[i].y)
            end
            if #loadingcircle ~= 0 then
                love.graphics.print(goqosi, loadingcircle[#loadingcircle].x, loadingcircle[#loadingcircle].y)
            end

        love.graphics.draw(arrow.image,
            arrow.x, arrow.y, arrow.angle, 1, 1,
            arrow.origin_x, arrow.origin_y)


        if core.list_draw ~= nil then
            for i = 1, #core.list_draw, 1 do
                love.graphics.draw(core.list_draw[i].image,
                core.list_draw[i].position.x, core.list_draw[i].position.y)
            end
        end


            --print(intersectionbox.x, "                  " , intersectionbox.y)
            --love.graphics.line(player.entity.position.x, player.entity.position.y, mmx, player.entity.position.y)
            --love.graphics.line(player.entity.position.x, player.entity.position.y, player.entity.position.x, mmy)
            --love.graphics.line(player.entity.position.x, player.entity.position.y, mmx, mmy)
        

    cam:detach()


end

function love.load()

    camera = require('camera')
    cam = camera()
    cam:zoom(0.5)

    mmx = 0
    mmy = 0

    love.keyboard.setKeyRepeat(true)

    box_image = love.graphics.newImage("box.png")

    my_box = entityCreator:new()
    my_box:set_position(800, 100)
    my_box:set_collision(64,64)
    my_box:load_image(box_image)
    my_box:set_velocity(0)
    core:add_collision(my_box)
    core:add_drawable(my_box)

    my_box2 = entityCreator:new()
    my_box2:set_position(1000, 100)
    my_box2:set_collision(64,64)
    my_box2:load_image(box_image)
    my_box2:set_velocity(0)
    core:add_collision(my_box2)
    core:add_drawable(my_box2)

    my_box3 = entityCreator:new()
    my_box3:set_position(900, 500)
    my_box3:set_collision(64,64)
    my_box3:load_image(box_image)
    my_box3:set_velocity(0)
    core:add_collision(my_box3)
    core:add_drawable(my_box3)


    arrow = {}
    arrow.x = 200
    arrow.y = 200
    arrow.speed = 300
    arrow.angle = 0
    arrow.image = love.graphics.newImage("arrow.png")
    arrow.origin_x = arrow.image:getWidth() / 2
    arrow.origin_y = arrow.image:getHeight() / 2


    player.sprite = love.graphics.newImage("player.png")
    player.entity:set_collision(64,128)
end


function love.mousemoved()
    mmx, mmy = cam:mousePosition()
    --print("X ", love.mouse.getX(), " PlayerPositionX ", player.entity.position.x)
    --print("Y ", love.mouse.getY(), " PlayerPositionY ", player.entity.position.y)
    local playerX, playerY = player.entity.position.x - 25 , player.entity.position.y - 25
    distanceX = mmx - playerX
    distanceY = mmy - playerY
    --print("distanceX ", distanceX , " distanceY ", distanceY)
    local distance = math.sqrt(distanceX + distanceY)
    local angle = math.atan2(distanceY, distanceX)
    local pupilX = player.entity.position.x + (math.cos(angle) * distance)
    local pupilY = player.entity.position.y + (math.sin(angle) * distance)
    player.faceangle = angle
    arrow.angle = angle
    --print("angle " ,angle)




    radiusup = radiusup + 1
    
end

local collision_flags = {top = false, down = false, left = false, right = false}

function love.update(dt)

    player.entity:set_velocity(5)


    my_time = my_time + dt
    if my_time >= 0.1 then
        timerupdate()

        my_time = 0
    end


    player:movement()
    

    cam:lookAt(player.entity.position.x + 32, player.entity.position.y + 64)
end


function love.keypressed(key, isrepeat)

end

function timerupdate() 
--print("timer")

    local xx = localradius*2 * math.cos(anglexxyy) + 400 
    local yy = localradius * math.sin(anglexxyy) + 50
    local object = {x = xx, y = yy}
    table.insert(loadingcircle, object)
    anglexxyy = anglexxyy + 0.01
    
end



