ponies = {
  pinkie = {
    love.graphics.newImage('assets/pinkie-0.png'),
    love.graphics.newImage('assets/pinkie-1.png'),
    love.graphics.newImage('assets/pinkie-2.png'),
    love.graphics.newImage('assets/pinkie-3.png'),
    love.graphics.newImage('assets/pinkie-4.png'),
    love.graphics.newImage('assets/pinkie-5.png'),
    love.graphics.newImage('assets/pinkie-6.png'),
    love.graphics.newImage('assets/pinkie-7.png'),
  },
  rarity = {
    love.graphics.newImage('assets/rarity-0.png'),
    love.graphics.newImage('assets/rarity-1.png'),
    love.graphics.newImage('assets/rarity-2.png'),
    love.graphics.newImage('assets/rarity-3.png'),
    love.graphics.newImage('assets/rarity-4.png'),
    love.graphics.newImage('assets/rarity-5.png'),
    love.graphics.newImage('assets/rarity-6.png'),
    love.graphics.newImage('assets/rarity-7.png'),
    love.graphics.newImage('assets/rarity-8.png'),
    love.graphics.newImage('assets/rarity-9.png'),
    love.graphics.newImage('assets/rarity-10.png'),
    love.graphics.newImage('assets/rarity-11.png'),
    love.graphics.newImage('assets/rarity-12.png'),
    love.graphics.newImage('assets/rarity-13.png'),
    love.graphics.newImage('assets/rarity-14.png'),
    love.graphics.newImage('assets/rarity-15.png'),
  },
  twilight = {
    love.graphics.newImage('assets/twilight-0.png'),
    love.graphics.newImage('assets/twilight-1.png'),
    love.graphics.newImage('assets/twilight-2.png'),
    love.graphics.newImage('assets/twilight-3.png'),
    love.graphics.newImage('assets/twilight-4.png'),
    love.graphics.newImage('assets/twilight-5.png'),
    love.graphics.newImage('assets/twilight-6.png'),
    --love.graphics.newImage('assets/twilight-7.png'),
    --love.graphics.newImage('assets/twilight-8.png'),
    love.graphics.newImage('assets/twilight-9.png'),
    --love.graphics.newImage('assets/twilight-10.png'),
    love.graphics.newImage('assets/twilight-11.png'),
    love.graphics.newImage('assets/twilight-12.png'),
    love.graphics.newImage('assets/twilight-13.png'),
    love.graphics.newImage('assets/twilight-14.png'),
  },
  applejack = {
    love.graphics.newImage('assets/applejack-0.png'),
    love.graphics.newImage('assets/applejack-1.png'),
    love.graphics.newImage('assets/applejack-2.png'),
    love.graphics.newImage('assets/applejack-3.png'),
    love.graphics.newImage('assets/applejack-4.png'),
    love.graphics.newImage('assets/applejack-5.png'),
    love.graphics.newImage('assets/applejack-6.png'),
    love.graphics.newImage('assets/applejack-7.png'),
    love.graphics.newImage('assets/applejack-8.png'),
    love.graphics.newImage('assets/applejack-9.png'),
    love.graphics.newImage('assets/applejack-10.png'),
    love.graphics.newImage('assets/applejack-11.png'),
    love.graphics.newImage('assets/applejack-12.png'),
    love.graphics.newImage('assets/applejack-13.png'),
    love.graphics.newImage('assets/applejack-14.png'),
    love.graphics.newImage('assets/applejack-15.png'),
  },
  fluttershy = {
    love.graphics.newImage('assets/fluttershy-0.png'),
    love.graphics.newImage('assets/fluttershy-1.png'),
    love.graphics.newImage('assets/fluttershy-2.png'),
    love.graphics.newImage('assets/fluttershy-3.png'),
    love.graphics.newImage('assets/fluttershy-4.png'),
    love.graphics.newImage('assets/fluttershy-5.png'),
    love.graphics.newImage('assets/fluttershy-6.png'),
    love.graphics.newImage('assets/fluttershy-7.png'),
    love.graphics.newImage('assets/fluttershy-8.png'),
    love.graphics.newImage('assets/fluttershy-9.png'),
    love.graphics.newImage('assets/fluttershy-10.png'),
    love.graphics.newImage('assets/fluttershy-11.png'),
    love.graphics.newImage('assets/fluttershy-12.png'),
    love.graphics.newImage('assets/fluttershy-13.png'),
  },
  rainbowdash = {
    love.graphics.newImage('assets/rainbowdash-0.png'),
    love.graphics.newImage('assets/rainbowdash-1.png'),
    love.graphics.newImage('assets/rainbowdash-2.png'),
    love.graphics.newImage('assets/rainbowdash-3.png'),
    love.graphics.newImage('assets/rainbowdash-4.png'),
    love.graphics.newImage('assets/rainbowdash-5.png'),
    love.graphics.newImage('assets/rainbowdash-6.png'),
    love.graphics.newImage('assets/rainbowdash-7.png'),
    love.graphics.newImage('assets/rainbowdash-8.png'),
    love.graphics.newImage('assets/rainbowdash-9.png'),
    love.graphics.newImage('assets/rainbowdash-10.png'),
    love.graphics.newImage('assets/rainbowdash-11.png'),
    love.graphics.newImage('assets/rainbowdash-12.png'),
    love.graphics.newImage('assets/rainbowdash-13.png'),
    love.graphics.newImage('assets/rainbowdash-14.png'),
    love.graphics.newImage('assets/rainbowdash-15.png'),
  },
}

pony = {
  _vx = 0,
  _vy = 0,
  _sx = -1,
  _flip_timer = 1/20,
  _idx = 1,
  _t = 0,
}

function pony:setPosition(x, y)
  self.x = x
  self.y = y
end

function pony:setPony(p)
  self._idx = 1
  self._frames = p
  self._numframes = table.getn(p)
  self._w = p[1]:getWidth()
  self._h = p[1]:getHeight()
end

function pony:goleft()
  self._vx = -300
  self._sx = -1
end

function pony:goright()
  self._vx = 300
  self._sx = 1
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

  -- animate!
  if math.abs(self._vx) > 4 then
    self._t = self._t + dt
    if self._t > self._flip_timer then
      self._idx = self._idx + 1
      if self._idx == self._numframes then
        self._idx = 1
      end
      self._t = 0
    end
  else
    self._idx = 1
  end
end

function pony:draw()
  love.graphics.draw(self._frames[self._idx],
                     self.x, self.y, 0,
                     self._sx, 1,
                     self._w / 2, self._h / 2)
end


