require "Player"
require "Ball"
require "Enemy"

function love.load()
	ballHit = love.audio.newSource("res/hit.wav")

	love.graphics.setNewFont(12)
	love.graphics.setColor(0,0,0)
	love.graphics.setBackgroundColor(255,255,255)
	
	bg = love.graphics.newImage("res/metal_blue.png")
	bgTiles = {}
	for i = 1, math.ceil(love.graphics.getWidth() / bg:getWidth()) do
		bgTiles[i] = {}
		for j = 1, math.ceil(love.graphics.getHeight() / bg:getHeight()) do
			bgTiles[i][j] = 0
		end
	end
	
	paddle = Player:new()
	paddle:initialize(16, 240)
	
	enemy = Enemy:new()
	enemy:initialize(640 - 32, 240)
	
	ball = Ball:new()
	ball:initialize(320, 240)
end

function love.draw()
	drawBackground()
	paddle:draw()
	enemy:draw()
	ball:draw()
end

function love.update(dt)
	paddle:update(dt)
	enemy:update()
	ball:update(dt)
end

function love.focus(f)
	if not f then
		print("LOST FOCUS")
	else
		print("GAINED FOCUS")
	end
end

function love.quit()
	print("Quit the game")
end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end

function drawBackground()
	for i = 1, table.getn(bgTiles) do
		for j = 1, table.getn(bgTiles[i]) do
			love.graphics.draw(bg, (i - 1) * bg:getWidth(), (j - 1) * bg:getHeight())
		end
	end
end

function SIGNUM(x)
	if x > 0 then return 1 elseif x < 0 then return -1 else return 0 end
end