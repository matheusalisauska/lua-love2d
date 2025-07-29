function Plant(seed, posX, posY)
	local timer = 0
	local interval = 4
	local scaleTimer = 0
	local scaleInterval = interval
	local Seeds = require("data.Seeds")

	if not seed then
		return
	end

	local seed = Seeds[seed]

	local progressBarSprite = love.graphics.newImage("assets/progress_bar.png")

	local currentStage = 1
	local bigFont = love.graphics.newFont(18)
	return {
		scale = 1.0,
		update = function(self, dt)
			if currentStage == #seed.sprites then
				return
			end

			timer = timer + dt

			if currentStage > 1 then
				scaleTimer = scaleTimer + dt

				local scaleProgress = scaleTimer / scaleInterval
				self.scale = 0.9 + (0.1 * scaleProgress)
			else
				self.scale = 1.0
			end

			if timer >= interval then
				timer = timer - interval
				scaleTimer = 0
				if currentStage < #seed.sprites then
					currentStage = currentStage + 1
				end

				if currentStage > 1 then
					self.scale = 0.9
				end

				if currentStage == #seed.sprites then
					self.scale = 1.0
				end
			end
		end,

		mousePressed = function(self, x, y, button)
			if currentStage == #seed.sprites and button == 1 then
				local sprite = seed.sprites[currentStage]
				local ox = (sprite:getWidth() / 2) * self.scale
				local oy = sprite:getHeight() * self.scale

				local plantY = currentStage == 1 and posY or posY - 40

				if x >= posX - ox and x <= posX + ox and y >= plantY - oy and y <= plantY then
					return true
				end
			end
			return false
		end,

		isFullyGrown = function(self)
			return currentStage == #seed.sprites
		end,

		draw = function(self)
			local sprite = seed.sprites[currentStage]
			local ox = sprite:getWidth() / 2
			local oy = sprite:getHeight()
			if currentStage == 1 then
				love.graphics.draw(sprite, posX, posY, 0, self.scale, self.scale, ox, oy)
			else
				love.graphics.draw(sprite, posX, posY - 40, 0, self.scale, self.scale, ox, oy)
			end

			local barWidth = progressBarSprite:getWidth() - 6
			local barHeight = progressBarSprite:getHeight() - 5
			local x = posX - 70
			local y = posY + 15

			local progress = timer / interval

			if currentStage < #seed.sprites then
				love.graphics.setColor(0.2, 0.8, 0.2)
				love.graphics.rectangle("fill", x + 2, y + 3, barWidth * progress, barHeight)

				love.graphics.setFont(bigFont)
				love.graphics.setColor(0, 0, 0)
				love.graphics.print(seed.name, x + 55, y + 50)
				love.graphics.print(string.format("%.1fs", interval - timer), x + 55, y + 25)
				love.graphics.setColor(1, 1, 1)
				love.graphics.draw(progressBarSprite, x, y)
			else
				love.graphics.setColor(0.2, 0.8, 0.2)
				love.graphics.rectangle("fill", x + 2, y + 3, barWidth, barHeight)
				love.graphics.setFont(bigFont)
				love.graphics.setColor(0, 0, 0)
				love.graphics.print("Complete", x + 30, y + 25)
				love.graphics.setColor(1, 1, 1)
				love.graphics.draw(progressBarSprite, x, y)
			end
		end,
	}
end

return Plant
