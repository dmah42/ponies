require('camera')
require('math')
require('parallax')

math.randomseed(os.time())

function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end

gameIsPaused = false

function love.load(args)
  love.graphics.setBackgroundColor(90,100,110)

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  t = 0

  local pinkie = love.graphics.newImage('pinkie.png')
  local blink = love.graphics.newImage('pinkie_blink.png')

  player = {
    x = 200, y = height - 200,
    i = { pinkie, blink },
    w = pinkie:getWidth(), h = pinkie:getHeight(),
    v = 300,
    s = -1,
    flip_timer = math.random(4, 10),
    idx = 1,
  }

  box = {
    x = 0, y = 0,
    w = width * 2, h = height * 2,
    c = { 255, 200, 20 }
  }

  for i = .5, 3, .5 do
    local stuff = {}

    local c = math.random(60, 80) * i

    for j = 1, math.random(2, 8) do
      table.insert(stuff, {
        x = 0,
        y = math.random(100, height),
        w = math.random(200, width * 2),
        h = math.random(200, height),
        c = { c, c, c },
      })
    end

    parallax:add(i, function()
      for _, v in ipairs(stuff) do
        love.graphics.setColor(v.c)
        love.graphics.rectangle('fill', v.x, v.y, v.w, v.h)
      end
    end)
  end
end

function love.focus(f) gameIsPaused = not f end

function love.update(dt)
  if gameIsPaused then return end

  local v = player.v * dt

  -- if love.keyboard.isDown("up") then
  --   player.y = player.y - v
  -- end
  -- if love.keyboard.isDown("down") then
  --   player.y = player.y + v
  -- end
  if love.keyboard.isDown("left") then
    player.x = player.x - v
    player.s = 1
  end
  if love.keyboard.isDown("right") then
    player.x = player.x + v
    player.s = -1
  end


  player.x = math.clamp(player.x, player.w / 2, 2 * width - player.w / 2)
  player.y = math.clamp(player.y, player.h / 2, 2 * height - player.h / 2)

  camera:translate(player.x - width / 2, player.y - height / 2)

  -- blink!
  t = t + dt
  if t > player.flip_timer then
    if player.idx == 1 then
      player.idx = 2
      player.flip_timer = 0.3
    elseif player.idx == 2 then
      player.idx = 1
      player.flip_timer = math.random(4, 10)
    end
    t = 0
  end
end

function love.draw()
  camera:set()

  -- box
  love.graphics.setColor(box.c)
  love.graphics.rectangle('line', box.x, box.y, box.w, box.h)

  -- stuff
  parallax:draw()

  -- player
  love.graphics.draw(player.i[player.idx], player.x, player.y, 0, player.s, 1, player.w / 2, player.h / 2)

  camera:unset()

  love.graphics.setColor(0, 0, 0)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 2, 2)
  love.graphics.print(camera._x .. " " .. camera._y, 2, 16)
end

function love.keypressed(key)
  if key == ' ' then
    love.load()
  elseif key == 'escape' then
    love.event.quit()
  end
end
