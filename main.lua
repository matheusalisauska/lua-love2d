local Slot = require("objects.Slot")
local CloudGenerator = require("objects.CloudGenerator")
local Plant = require("objects.Plant")
local Hud = require("objects.Hud")
local ShopHud = require("objects.shop_hud.ShopHud")
cursorSprite = love.graphics.newImage("assets/cursor.png")
local smallSeed = love.graphics.newImage("assets/small_seed.png")

Game = {
	money = 1,
	cursorSprite = love.graphics.newImage("assets/cursor.png"),
	carringSeed = nil,
}

local sprite = love.graphics.newImage("assets/bg.png")

function love.load()
	love.mouse.setVisible(false)
	cloudGenerator = CloudGenerator()
	SCREEN_WIDTH = 1920
	SCREEN_HEIGHT = 1080
	love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
	plant = Plant(300, 980)
	local slot1 = Slot({ locked = false, x = 300, y = 980 })
	local slot2 = Slot({ locked = true, x = 700, y = 980 })
	local slot3 = Slot({ locked = true, x = 1100, y = 980 })
	hud = Hud()
	shopHud = ShopHud()
	slots = { slot1, slot2, slot3 }
end

function love.update(dt)
	cloudGenerator:update(dt)
	for _, slot in ipairs(slots) do
		slot:update(dt)
	end
end

function love.mousepressed(x, y, k)
	print(x .. y .. k)
	for _, slot in ipairs(slots) do
		slot:mousePressed(x, y, k)
	end
	shopHud:mousePressed(x, y, k)
end

function love.draw()
	love.graphics.draw(sprite, 0, 0)
	cloudGenerator:draw()
	-- plant:draw()
	hud:draw()
	for _, slot in ipairs(slots) do
		slot:draw()
	end
	shopHud:draw()
	love.graphics.draw(Game.cursorSprite, love.mouse.getX(), love.mouse.getY(), 0, 0.7, 0.7)

	if Game.carringSeed then
		love.graphics.draw(smallSeed, love.mouse.getX() + 30, love.mouse.getY())
	end
end
