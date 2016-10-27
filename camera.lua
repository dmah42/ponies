camera = {
  _x = 0,
  _y = 0,
  _scaleX = 1,
  _scaleY = 1,
  _rotation = 0
}

function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self._rotation)
  love.graphics.scale(1 / self._scaleX, 1 / self._scaleY)
  love.graphics.translate(-self._x, -self._y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)
  self._x = self._x + (dx or 0)
  self._y = self._y + (dy or 0)
end

function camera:rotate(dr)
  self._rotation = self._rotation + (dr or 0)
end

function camera:scale(sx, sy)
  sx = sx or 1
  self._scaleX = self._scaleX * sx
  self._scaleY = self._scaleY * (sy or sx)
end

function camera:translate(x, y)
  self._x = x or self._x
  self._y = y or self._y
end
