function Hud()
	local sprite = love.graphics.newImage("assets/money_hud.png")
	local bigFont = love.graphics.newFont(32)

	return {
		draw = function(self)
			love.graphics.setFont(bigFont)
			love.graphics.draw(sprite, 60, 80)
			love.graphics.setColor(0, 0, 0)
			love.graphics.print(Game.money, 150, 95)
			love.graphics.setColor(1, 1, 1)
		end,
	}
end

return Hud
