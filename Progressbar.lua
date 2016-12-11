Progressbar = {img = nil, timeToLive = 5, percentComplete = 0, bars = 10, gutter = 7}

function Progressbar:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Progressbar:draw()
	x = love.graphics:getWidth()/2 - Progressbar.img:getWidth()/2
	y = love.graphics:getHeight()/2 - Progressbar.img:getHeight()/2
	love.graphics.draw(Progressbar.img, x, y)
	ox = x + 88
	oy = y + 83
	width = Progressbar.img:getWidth() - 2 * 88
	height = Progressbar.img:getHeight() - 2 * 83
	boxWidth = (width - (Progressbar.bars - 1) * Progressbar.gutter) / Progressbar.bars
	boxHeight = 177
	for i = 0, Progressbar.bars - 1 do
		if i / (Progressbar.bars - 1) <= Progressbar.percentComplete / 100 then
			love.graphics.setColor(117, 231, 0, 255)
		else
			love.graphics.setColor(93, 27, 27, 255)
		end
		love.graphics.rectangle("fill", ox + i * (boxWidth + Progressbar.gutter), oy, boxWidth, boxHeight)
	end
end

function Progressbar:setImg(newImage)
  Progressbar.img = newImage
end

function Progressbar:getPercentage()
  return Progressbar.percentComplete
end

function Progressbar:setPercentage(newValue)
  Progressbar.percentComplete = newValue
end

function Progressbar:getTimeToLive()
  return Progressbar.timeToLive
end
