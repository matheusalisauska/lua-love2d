function Cloud(x, y)
	local image = love.graphics.newImage("assets/cloud.png")
	local width = image:getWidth()

	return {
		x = x,
		y = y,
		image = image,
		speed = love.math.random(50, 100),
		size = love.math.random() * 0.4 + 0.6,
		flipped = love.math.random() < 0.5,
		update = function(self, dt)
			self.x = self.x + self.speed * dt
		end,

		draw = function(self)
			local scaleX = self.flipped and -self.size or self.size
			local offsetX = self.flipped and self.image:getWidth() or 0

			love.graphics.draw(self.image, self.x + offsetX, self.y, 0, scaleX, self.size)
		end,

		isOffScreen = function(self)
			return self.x > love.graphics.getWidth() + width
		end,
	}
end

return Cloud
