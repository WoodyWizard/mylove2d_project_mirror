local playerCore = require("playerEntity")
local entityCreator = require('entity')
local core = require('core')
local anim8 = require('anim8')

local player = playerCore:new()
--player.entity.position.x = 400
--player.entity.position.y = 400

local my_time = 0
local anglexxyy = 0.0
local localradius = 50
local loadingcircle = {}


function love.draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["ground"])
        gameMap:drawLayer(gameMap.layers["trees"])
        gameMap:drawLayer(gameMap.layers["wallsandcollide"])
        
            core:draw()
            
        player.anim:draw(player.spritesheet, player.entity.position.x, player.entity.position.y, nil)

        local player_info = string.format("X: %u Y: %u", player.entity.position.x, player.entity.position.y)
        love.graphics.print(player_info, font , player.entity.position.x, player.entity.position.y - 100)

    cam:detach()
end


function love.load()
    mmx = 0
    mmy = 0
    font = love.graphics.newFont("AlexandriaFLF.ttf", 64)
    love.keyboard.setKeyRepeat(true)
    love.window.setFullscreen( true )
    --love.graphics.setDefaultFilter( "nearest" )
    sti = require('sti')
    gameMap = sti('mymap.lua')
    camera = require('camera')
    cam = camera()
    cam:zoom(0.5)
    box_image = love.graphics.newImage("box.png")
    core:init()

    for i = 1, gameMap.layers["wallsandcollide"].height, 1 do
        for b = 1, gameMap.layers["wallsandcollide"].width, 1 do
            if gameMap.layers["wallsandcollide"].data[b][i] ~= nil then
                for collision_id_counter = 1, #core.collision_id_list, 1 do
                    if gameMap.layers["wallsandcollide"].data[b][i].gid == core.collision_id_list[collision_id_counter] then
                        localCollisionObject = entityCreator:new()
                        localCollisionObject:set_position((i*64)-64, (b*64)-64)
                        localCollisionObject:set_collision(64,64)
                        localCollisionObject:set_velocity(0)
                        localCollisionObject:set_type("wall")
                        localCollisionObject:set_ignore("none")
                        core:add_collision(localCollisionObject)
                    end
                end
            end
        end
    end
    
    my_box = entityCreator:new()
    my_box:set_position(800, 100)
    my_box:set_collision(64,64)
    my_box:load_image(box_image)
    my_box:set_velocity(0)
    my_box:set_type("box")
    core:add_collision(my_box)
    core:add_drawable(my_box)

    my_box2 = entityCreator:new()
    my_box2:set_position(1000, 100)
    my_box2:set_collision(64,64)
    my_box2:load_image(box_image)
    my_box2:set_velocity(0)
    my_box2:set_type("box")
    core:add_collision(my_box2)
    core:add_drawable(my_box2)

    my_box3 = entityCreator:new()
    my_box3:set_position(900, 500)
    my_box3:set_collision(64,64)
    my_box3:load_image(box_image)
    my_box3:set_velocity(0)
    my_box3:set_type("box")
    core:add_collision(my_box3)
    core:add_drawable(my_box3)

    my_portal = entityCreator:new()
    my_portal:set_position(-100,200)
    my_portal:set_collision(90,256)
    my_portal.spritesheet = love.graphics.newImage("portal.png")
    my_portal.grid = anim8.newGrid(230,545, my_portal.spritesheet:getWidth(), my_portal.spritesheet:getHeight())
    my_portal.animation = anim8.newAnimation(my_portal.grid('1-4', 1), 0.15)
    my_portal:set_scale(0.5)
    core:add_drawable(my_portal)

    arrow = entityCreator:new()
    arrow:set_position(-100,200)
    arrow.angle = 0
    arrow:load_image(love.graphics.newImage("hand.png"))
    arrow:set_velocity(0)
    arrow:set_scale(0.3)
    --arrow.origin_x = arrow.image:getWidth() / 2
    --arrow.origin_y = arrow.image:getHeight() / 2
    core:add_drawable(arrow)

    player.spritesheet = love.graphics.newImage("playerspritesheet.png")
    player.grid = anim8.newGrid(64,64, player.spritesheet:getWidth(), player.spritesheet:getHeight())
    player.sprite = love.graphics.newImage("player.png")
    player.animation = {}
    player.animation.default = anim8.newAnimation(player.grid('1-7',1), 0.05)
    player.animation.down = anim8.newAnimation(player.grid('1-7',2), 0.05)
    player.animation.up = anim8.newAnimation(player.grid('1-7',5), 0.05)
    player.animation.left = anim8.newAnimation(player.grid('1-4',4), 0.05)
    player.animation.right = anim8.newAnimation(player.grid('1-4',3), 0.05)
    player.anim = player.animation.default
    player.entity:set_collision(64,64)
    player.entity:set_velocity(8)
end


function love.mousemoved()
    mmx, mmy = cam:mousePosition()

    
end





function love.update(dt)
    my_time = my_time + dt
    if my_time >= 0.1 then
        timerupdate()
        my_time = 0
    end

    player:movement()

    my_portal.animation:update(dt)
    player.anim:update(dt)

    if my_portal:detect_collision(player.entity) then
        player.entity.position.x = 1000
        player.entity.position.y = 1000
    end

    local arrowMouseX, arrowMouseY = cam:mousePosition()
    local playerX, playerY = player.entity.position.x - 25 , player.entity.position.y - 25
    distanceX = arrowMouseX - playerX
    distanceY = arrowMouseY - playerY
    local distance = math.min(math.sqrt(distanceX^2 + distanceY^2), 80)
    local angle = math.atan2(distanceY, distanceX)
    local pupilX = player.entity.position.x + 8  + (math.cos(angle) * distance)
    local pupilY = player.entity.position.y + 16  + (math.sin(angle) * distance)
    arrow.position.x = pupilX
    arrow.position.y = pupilY

    if love.mouse.isDown(1) == true  then
        local xBullet = arrow.position.x + math.cos(angle) * 5
        local yBullet = arrow.position.y + math.sin(angle) * 5
        core:create_bullet(xBullet, yBullet, angle)
        print("Bullet")
    end

    if core.bullets ~= nil then
        for i = 1, #core.bullets, 1 do
            core.bullets[i].position.x = (core.bullets[i].position.x + math.cos(core.bullets[i].angle) * core.bullets[i].velocity * dt)
            core.bullets[i].position.y = (core.bullets[i].position.y + math.sin(core.bullets[i].angle) * core.bullets[i].velocity * dt)
        end
    end

    core:detect_bullet_collision()


    cam:lookAt(player.entity.position.x + 32, player.entity.position.y + 64)
    mousePressed = false
end


function love.keypressed(key, isrepeat)

end

function love.mousepressed()
    mousePressed = true
end


function timerupdate() 
    local xx = localradius * math.cos(anglexxyy) + 400 
    local yy = localradius * math.sin(anglexxyy) + 50
    local object = {x = xx, y = yy}
    table.insert(loadingcircle, object)
    anglexxyy = anglexxyy + 0.01
end



