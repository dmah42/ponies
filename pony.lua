ponies = {
  pinkie = {
    love.graphics.newImage('pinkie-0.png'),
    love.graphics.newImage('pinkie-1.png'),
    love.graphics.newImage('pinkie-2.png'),
    love.graphics.newImage('pinkie-3.png'),
    love.graphics.newImage('pinkie-4.png'),
    love.graphics.newImage('pinkie-5.png'),
    love.graphics.newImage('pinkie-6.png'),
    love.graphics.newImage('pinkie-7.png'),
  },
  rarity = {
    love.graphics.newImage('rarity-0.png'),
    love.graphics.newImage('rarity-1.png'),
    love.graphics.newImage('rarity-2.png'),
    love.graphics.newImage('rarity-3.png'),
    love.graphics.newImage('rarity-4.png'),
    love.graphics.newImage('rarity-5.png'),
    love.graphics.newImage('rarity-6.png'),
    love.graphics.newImage('rarity-7.png'),
    love.graphics.newImage('rarity-8.png'),
    love.graphics.newImage('rarity-9.png'),
    love.graphics.newImage('rarity-10.png'),
    love.graphics.newImage('rarity-11.png'),
    love.graphics.newImage('rarity-12.png'),
    love.graphics.newImage('rarity-13.png'),
    love.graphics.newImage('rarity-14.png'),
    love.graphics.newImage('rarity-15.png'),
  },
  twilight = {
    love.graphics.newImage('twilight-0.png'),
    love.graphics.newImage('twilight-1.png'),
    love.graphics.newImage('twilight-2.png'),
    love.graphics.newImage('twilight-3.png'),
    love.graphics.newImage('twilight-4.png'),
    love.graphics.newImage('twilight-5.png'),
    love.graphics.newImage('twilight-6.png'),
    --love.graphics.newImage('twilight-7.png'),
    --love.graphics.newImage('twilight-8.png'),
    love.graphics.newImage('twilight-9.png'),
    --love.graphics.newImage('twilight-10.png'),
    love.graphics.newImage('twilight-11.png'),
    love.graphics.newImage('twilight-12.png'),
    love.graphics.newImage('twilight-13.png'),
    love.graphics.newImage('twilight-14.png'),
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


