function Button(sprite, x, y, onClick)
	local width = sprite:getWidth()
	local height = sprite:getHeight()

	return {
		x = x,
		y = y,
		sprite = sprite,
		width = width,
		height = height,
		onClick = onClick,

		draw = function(self)
			love.graphics.draw(self.sprite, self.x, self.y)
		end,

		isHovered = function(self, mx, my)
			return mx >= self.x and mx <= self.x + self.width and my >= self.y and my <= self.y + self.height
		end,

		handleClick = function(self, mx, my)
			if self:isHovered(mx, my) and self.onClick then
				self.onClick()
			end
		end,
	}
end

return Button
