require('camera')
require('math')
require('parallax')
require('pony')

math.randomseed(os.time())

function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end

gameIsPaused = false

function love.load(args)
  love.graphics.setBackgroundColor(90,100,110)

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  pony:setPosition(200, height * 2 - 200)
  pony:setPony(ponies.pinkie)

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
  if gameIsPaused then
    -- track pony
    camera:translate(pony.x - width / 2, pony.y - height / 2)
    return
  end

  -- movement
  -- local vx = pony.vx * dt
  if love.keyboard.isDown('left') then
    pony:goleft()
  end
  if love.keyboard.isDown('right') then
    pony:goright()
  end

  -- jump
  if love.keyboard.isDown('space') then
    pony:jump()
  end

  pony:update(dt, width, height)

  -- track pony
  camera:translate(pony.x - width / 2, pony.y - height / 2)

end

function love.draw()
  camera:set()

  -- box
  love.graphics.setColor(box.c)
  love.graphics.rectangle('line', box.x, box.y, box.w, box.h)

  -- stuff
  parallax:draw()

  -- pony
  pony:draw()

  camera:unset()

  love.graphics.setColor(0, 0, 0)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 2, 2)
  love.graphics.print(camera._x .. " " .. camera._y, 2, 16)

  love.graphics.print(pony.x .. " " .. pony.y, 2, 64)
  love.graphics.print(pony._vx .. " " .. pony._vy, 2, 80)
end

function love.keypressed(key)
  if key == ' ' then
    love.load()
  elseif key == 'escape' then
    love.event.quit()
  end
end
