require "Player"

function love.load()
	love.graphics.setNewFont(12)
	love.graphics.setColor(0,0,0)
	love.graphics.setBackgroundColor(144,144,144)
	
	paddle = Player:new()
	paddle:initialize(16, 240)
end

function love.draw()
	love.graphics.print("Hello World", 400, 300)
	paddle:draw()
end

function love.update(dt)
	paddle:update(dt)
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