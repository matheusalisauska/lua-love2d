local ShopItem = require("objects.shop_hud.ShopItem")
local Seeds = require("data.Seeds")

function ShopHud()
	local font = love.graphics.newFont("assets/fonts/font_shop.ttf", 24)
	local sprite = love.graphics.newImage("assets/shop_hud/shop_bg.png")
	local items = {
		ShopItem(
			"Girassol",
			Seeds["Girassol"].price,
			love.graphics.newImage("assets/sunflower/sunflower_frame.png"),
			1530,
			150
		),
	}
	return {
		draw = function(self)
			love.graphics.draw(sprite, 1500, 100)

			for i, item in ipairs(items) do
				item:draw()
			end
		end,

		mousePressed = function(self, mx, my, k)
			for i, item in ipairs(items) do
				item:mousePressed(mx, my, k)
			end
		end,
	}
end

return ShopHud
