local Cloud = require("objects.Cloud")

function CloudGenerator()
	local clouds = {}
	local spawnTimer = 0
	local spawnInterval = 5

	return {
		update = function(self, dt)
			spawnTimer = spawnTimer + dt
			if spawnTimer >= spawnInterval then
				spawnTimer = spawnTimer - spawnInterval

				local y = love.math.random(30, 400)
				table.insert(clouds, Cloud(-300, y))
			end

			for i = #clouds, 1, -1 do
				local cloud = clouds[i]
				cloud:update(dt)
				if cloud:isOffScreen() then
					table.remove(clouds, i)
				end
			end
		end,

		draw = function(self)
			for _, cloud in ipairs(clouds) do
				cloud:draw()
			end
		end,
	}
end

return CloudGenerator
