Enemy = {
--Constants
SPEED = Ball.SPEED - 0.2,
RANGE = 20 --The range which the computer paddle can change directions
}

--Constructor
function Enemy:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--Initialize all fields
function Enemy:initialize(x, y)
	self.x = x
	self.y = y
	self.sprite = love.graphics.newImage("res/bat_medium.png")
	self.width = self.sprite:getWidth()
	self.height = self.sprite:getHeight()
	self.velX = 0
	self.velY = 0
	self.collidable = true
end

function Enemy:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, self.x, self.y)
end

function Enemy:update(dt)
	self:move(dt)
	--Keep within window borders
	if self.x + self.velX >= 0 and self.x + self.width + self.velX <= love.window.getWidth() then
		self.x = self.x + self.velX
	end
	if self.y + self.velY >= 0 and self.y + self.height + self.velY <= love.window.getHeight() then
		self.y = self.y + self.velY
	end
end

function Enemy:move(dt)
	--Follow the ball
	if ball.y < self.y + (self.height / 2) - Enemy.RANGE then self.velY = -Enemy.SPEED elseif ball.y > self.y + (self.height / 2) + Enemy.RANGE then self.velY = Enemy.SPEED end
	--X Collision
	if self:checkCollision(ball, self.x + self.velX, self.y) then
		while not self:checkCollision(ball, self.x + SIGNUM(self.velX), self.y) do
			self.x = self.x + SIGNUM(self.velX)
		end
		self.velX = 0 
	end
	--Y Collision
	if self:checkCollision(ball, self.x, self.y + self.velY) then
		while not self:checkCollision(ball, self.x, self.y + SIGNUM(self.velY)) do
			self.y = self.y + SIGNUM(self.velY)
		end
		self.velY = 0
	end
end

function Enemy:checkCollision(other, x, y)
	if not(other.collidable == nil) then
		if other.collidable then
			if(x < other.x + other.width and x + self.width > other.x and y < other.y + other.height and y + self.height > other.y) then
				return true;
			end
		end
	end
	return false
end
