require('camera')

parallax = {}
parallax._layers = {}

function parallax:add(scale, draw)
  table.insert(self._layers, { draw = draw, scale = scale })
  table.sort(self._layers, function(a, b) return a.scale < b.scale end)
end

function parallax:draw()
  for _, v in ipairs(self._layers) do
    camera:translate(camera._x * v.scale, camera._y * v.scale)
    camera:set()
    v.draw()
    camera:unset()
  end
end
