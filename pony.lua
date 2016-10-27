local pinkie = love.graphics.newImage('pinkie.png')
local blink = love.graphics.newImage('pinkie_blink.png')
local BLINK_TIMER = {4, 10}

ponies = {
  pinkie = {
    love.graphics.newImage('pinkie.png'),
    love.graphics.newImage('pinkie_blink.png')
  },
}

pony = {
  _vx = 0,
  _vy = 0,
  _sx = -1,
  _flip_timer = math.random(BLINK_TIMER[1], BLINK_TIMER[2]),
  _idx = 1,
  _t = 0,
}

function pony:setPosition(x, y)
  self.x = x
  self.y = y
end

function pony:setPony(p)
  self._frames = p
  self._w = p[1]:getWidth()
  self._h = p[1]:getHeight()
end

function pony:goleft()
  self._vx = -300
  self._sx = 1
end

function pony:goright()
  self._vx = 300
  self._sx = -1
end

function pony:jump()
  self._vy = -500
end

function pony:update(dt, width, height)
  self.x = self.x + self._vx * dt
  self.y = self.y + self._vy * dt

  -- friction
  self._vx = self._vx * 0.9
  if math.abs(self._vx) < 1 then
    self._vx = 0
  end

  -- gravity
  self._vy = self._vy + 1000 * dt

  -- bounds (TODO: replace with collisions)
  self.x = math.clamp(self.x, self._w / 2, 2 * width - self._w / 2)
  self.y = math.clamp(self.y, self._h / 2, 2 * height - self._h / 2)
  if self.x < self._w / 2 + 0.01 then
    self._vx = 0
  end
  if self.y > (2 * height - self._h / 2) - 0.01 then
    self._vy = 0
  end

  -- blink!
  self._t = self._t + dt
  if self._t > self._flip_timer then
    if self._idx == 1 then
      self._idx = 2
      self._flip_timer = 0.3
    elseif self._idx == 2 then
      self._idx = 1
      self._flip_timer = math.random(BLINK_TIMER[1], BLINK_TIMER[2])
    end
    self._t = 0
  end
end

function pony:draw()
  love.graphics.draw(self._frames[self._idx],
                     self.x, self.y, 0,
                     self._sx, 1,
                     self._w / 2, self._h / 2)
end


