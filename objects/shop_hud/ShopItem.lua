local Button = require("components.Button")

function ShopItem(name, price, image, x, y)
	local buyButtonSprite = love.graphics.newImage("assets/shop_hud/buy_button.png")
	local font = love.graphics.newFont("assets/fonts/font_shop.ttf", 28)
	local cursorGrab = love.graphics.newImage("assets/cursor_grab.png")

	return {
		button = Button(buyButtonSprite, 0, 0, function()
			if Game.money < price then
				print("Você não tem dinheiro pra comnprar a semente: " .. name)
				return
			end

			if Game.carringSeed then
				print("Você já está carregando uma semente: " .. Game.carringSeed)
				return
			end

			Game.cursorSprite = cursorGrab
			Game.carringSeed = name
			Game.money = Game.money - price
		end),

		draw = function(self)
			love.graphics.draw(image, x, y)
			love.graphics.setFont(font)
			love.graphics.setColor(0, 0, 0)
			love.graphics.print(name .. " - $" .. price, x + 120, y + 5)
			love.graphics.setColor(1, 1, 1)

			self.button.x = x + 120
			self.button.y = y + 40

			self.button:draw()
		end,

		mousePressed = function(self, mx, my, k)
			if k == 1 then
				self.button:handleClick(mx, my)
			end
		end,
	}
end

return ShopItem
