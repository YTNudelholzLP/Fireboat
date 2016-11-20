Slider = {x = 400, y = 110, width = 300, height = 80, barHeight = 20, position = 0.4, activeColorRed = 130, activeColorGreen = 149, activeColorBlue = 176,
 	inactiveColorRed = 88, inactiveColorGreen = 101, inactiveColorBlue = 120, markerColorRed = 255, markerColorGreen = 255, markerColorBlue = 255, markerWidth = 10,
   markerHeight = 30, draggingActive = false }

  function Slider:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
  end

	function  Slider:draw()
			love.graphics.setColor(self.activeColorRed, self.activeColorGreen, self.activeColorBlue)
			love.graphics.rectangle("fill", self.x, self.y + (self.height - self.barHeight) / 2, self.position * self.width, self.barHeight)
      love.graphics.setColor(self.inactiveColorRed, self.inactiveColorGreen, self.inactiveColorBlue)
      love.graphics.rectangle("fill", self.x + self.position * self.width, self.y + (self.height - self.barHeight) / 2, (1 - self.position) * self.width, self.barHeight)
      love.graphics.setColor(self.markerColorRed, self.markerColorGreen, self.markerColorBlue)
      love.graphics.rectangle("fill", self.x + self.position * self.width - self.markerWidth / 2, self.y + self.height / 2 - self.markerHeight / 2,
       self.markerWidth, self.markerHeight, 0.5 * self.markerWidth, 0.5 * self.markerWidth)
			love.graphics.setColor(255, 255, 255, 255)
	end

  function Slider:mousepressed(x, y, button)
    if x >= self.x + self.position * self.width - self.markerWidth / 2
      and x <= self.x + self.position * self.width + self.markerWidth / 2
      and y >= self.y + self.height / 2 - self.markerHeight / 2
      and y <= self.y + self.height / 2 + self.markerHeight / 2 then
        self.draggingActive = true
    end
  end

  function Slider:mousereleased(x, y, button, istouch)
    self.draggingActive = false
  end

  function Slider:update(dt)
    if self.draggingActive then
      self.position = (love.mouse.getX() - self.x) / self.width
      if self.position < 0 then
        self.position = 0
      end
      if self.position > 1 then
        self.position = 1
      end
      self:updated(self.position)
    end
  end
