require "Player"
require "Ball"
require "Enemy"

function love.load()
	love.graphics.setNewFont(12)
	love.graphics.setColor(0,0,0)
	love.graphics.setBackgroundColor(144,144,144)
	
	paddle = Player:new()
	paddle:initialize(16, 240)
	
	enemy = Enemy:new()
	enemy:initialize(640 - 32, 240)
	
	ball = Ball:new()
	ball:initialize(320, 240)
end

function love.draw()
	love.graphics.print("Hello World", 400, 300)
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

function SIGNUM(x)
	if x > 0 then return 1 elseif x < 0 then return -1 else return 0 end
end