core = require('core')
local anim8 = require('anim8')
local bump = require 'bump.bump'

local my_time = 0

function love.draw()
        core.engine:draw()
end

local test_object = class("test_object")

function test_object:test()
	print("something TEST OBJECT")
end



function love.load()
    mmx = 0
    mmy = 0
    font = love.graphics.newFont("AlexandriaFLF.ttf", 64)
    love.window.setMode(1920,1080)
    --love.window.setVSync(true)
    love.keyboard.setKeyRepeat(true)
    --love.window.setFullscreen( true )
    
    --love.graphics.setDefaultFilter( "linear", "linear", 16 )
    --love.graphics.setDefaultFilter("nearest", "nearest")
    --love.graphics.setDefaultFilter("nearest")
    
    sti = require('sti')
    camera = require('camera')
    cam = camera()
    cam:zoom(1)
    box_image = love.graphics.newImage("box.png")
    hand_image = love.graphics.newImage("hand.png")
    turret_image = love.graphics.newImage("turret.png")
    bullet_image = love.graphics.newImage("bullet.png")
    PARTICLE = love.graphics.newImage("particle1.png")

	psystem = love.graphics.newParticleSystem(PARTICLE, 128)
	psystem:setParticleLifetime(1, 2) -- Particles live at least 2s and at most 5s.
	psystem:setEmitterLifetime(2)
	psystem:setEmissionRate(1)
	psystem:setSizes(0.1)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

    core:init()
    core:load_systems()
    core:init_collision()
    
    core:create_entity({
        core:add_component("tilemap")(sti('mymap.lua'))
    })
    core:init_tilemap()

    local player_animation = {}
    local player_spritesheet = love.graphics.newImage("playerspritesheet.png")
    local player_grid = anim8.newGrid(64,64, player_spritesheet:getWidth(), player_spritesheet:getHeight())
    player_animation.default = anim8.newAnimation(player_grid('1-7',1), 0.05)
    player_animation.down = anim8.newAnimation(player_grid('1-7',2), 0.05)
    player_animation.up = anim8.newAnimation(player_grid('1-7',5), 0.05)
    player_animation.left = anim8.newAnimation(player_grid('1-4',4), 0.05)
    player_animation.right = anim8.newAnimation(player_grid('1-4',3), 0.05)
    player_animation.current = player_animation.default

    core:create_entity( { 
                            core:add_component("base")(100,100), 
                            core:add_component("velocity")(500,500), 
                            core:add_component("player")(1),
                            core:add_component("animation")(player_spritesheet, player_grid , player_animation) ,
                            core:add_component("camera")(cam),
                            core:add_component("collision")(nil, 'player'),
			    core:add_component("hand")(0,0,hand_image),
			    core:add_component("team")('general'),
			    core:add_component("object")()
                        })

    core:create_entity({
			    core:add_component("base")(500,500, 64,64),
			    core:add_component("area")(),
			    core:add_component("turret")(500),
			    core:add_component("collision")(nil, 'turret'),
			    core:add_component("team")('turret_team'),
			    core:add_component("draw")(0.4,0,turret_image),
			    core:add_component("object")()
    })

    --core.eventmanager:addListener("test_object", test_object, test_object.test)
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
	psystem:update(dt)
    local arrowMouseX, arrowMouseY = cam:mousePosition()
    --[[
    local playerX, playerY = player.entity.position.x - 25 , player.entity.position.y - 25
    distanceX = arrowMouseX - playerX
    distanceY = arrowMouseY - playerY
    local distance = math.min(math.sqrt(distanceX^2 + distanceY^2), 80)
    local angle = math.atan2(distanceY, distanceX)
    local pupilX = player.entity.position.x + 8  + (math.cos(angle) * distance)
    local pupilY = player.entity.position.y + 16  + (math.sin(angle) * distance)
    arrow.position.x = pupilX
    arrow.position.y = pupilY
    ]]--

    core.engine:update(dt)
end


function love.keypressed(key, isrepeat)

end


function love.mousepressed()
	--core.eventmanager:fireEvent(test_object())
end


function timerupdate() 

end

	
