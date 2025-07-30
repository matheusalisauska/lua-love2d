local Seeds = require("data.Seeds")
local lockSprite = love.graphics.newImage("assets/lock.png")
function Slot(opts)
	local sprite = love.graphics.newImage("assets/slot.png")
	local dirtSprite = love.graphics.newImage("assets/dirt.png")
	local bigFont = love.graphics.newFont(18)

	return {
		currentPlant = nil,
		plant = opts.plant or nil,
		locked = opts.locked or false,
		x = opts.x or 0,
		y = opts.y or 0,

		update = function(self, dt)
			if self.plant then
				self.plant:update(dt)
			end
		end,

		newPlant = function(self, newPlant)
			if not self.locked then
				self.plant = newPlant
				print("Nova planta adicionada: " .. self.x .. ", " .. self.y)
			else
				print("Slot bloqueado!")
			end
		end,

		mousePressed = function(self, x, y, k)
			if not self.locked and k == 1 then
				-- Verify pra ver se a planta está totalmente crescida
				if self.plant and self.plant:isFullyGrown() then
					if self.plant:mousePressed(x, y, k) then
						Game.money = Game.money + Seeds[self.currentPlant].salesPrice
						self.plant = nil
						return
					end
				end

				--Cria uma nova planta
				if not self.plant then
					if
						x >= self.x - sprite:getWidth() / 2
						and x <= self.x + sprite:getWidth() / 2
						and y >= self.y - sprite:getHeight()
						and y <= self.y
					then
						self.currentPlant = Game.carringSeed
						Game.cursorSprite = love.graphics.newImage("assets/cursor.png")
						self:newPlant(Plant(Game.carringSeed, self.x, self.y))
						Game.carringSeed = nil
					else
						print("Clicou fora")
					end
				end
			else
				print("Locked")
			end
		end,

		draw = function(self)
			local ox = sprite:getWidth() / 2
			local oy = sprite:getHeight()

			if self.plant then
				love.graphics.draw(dirtSprite, self.x, self.y - 8, 0, 1, 1, ox, oy)
			else
				love.graphics.draw(sprite, self.x, self.y, 0, 1, 1, ox, oy)
			end

			if self.plant then
				self.plant:draw()
			end

			if self.locked then
				love.graphics.setFont(bigFont)
				love.graphics.draw(lockSprite, self.x - 25, self.y + 15)
				love.graphics.setColor(1, 1, 1)
			end
		end,
	}
end

return Slot
