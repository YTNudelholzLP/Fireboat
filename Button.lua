Button = {x = 400, y = 110, width = 300, height = 80, offsetx = 5, offsety = 5, backgroundColorRed = 130, backgroundColorGreen = 149, backgroundColorBlue = 176,
 backgroundImg = nil,text = "Button", drawBorder = false }

 function Button:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
 end

   	function  Button:draw()
      	if self.backgroundImg ~= nil then
      		love.graphics.draw(self.backgroundImg, self.x, self.y,0, self.width/self.backgroundImg:getWidth(),
      	 		self.height/self.backgroundImg:getHeight())
      	else
      		love.graphics.setColor(self.backgroundColorRed, self.backgroundColorGreen, self.backgroundColorBlue)
      		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
      		love.graphics.setColor(255, 255, 255, 255)
      	end
        if drawBorder then
      	   love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        end
      	love.graphics.print(self.text,self.x +  self.offsetx,self.y + self.offsety)

      end

    function Button:mousereleased(x, y, button, istouch)
      if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
        self:clicked()
      end
    end

      function Button:update(dt)

      end
