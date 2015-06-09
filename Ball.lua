Ball = {
--Constants
SPEED = 5
}

--Constructor
function Ball:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--Initialize all fields
function Ball:initialize(x, y)
	self.x = x
	self.y = y
	self.startX = x
	self.startY = y
	self.sprite = love.graphics.newImage("res/ball_blue.png")
	self.width = self.sprite:getWidth()
	self.height = self.sprite:getHeight()
	self:setVelocity()
	self.collidable = true
end

function Ball:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, self.x, self.y)
end

function Ball:update(dt)
	--Keep within window borders
	if not(self.y + self.velY >= 0 and self.y + self.height + self.velY <= love.window.getHeight()) then --bounce off top & bottom edges
		self.velY = self.velY * -1 --bounce only happens with this object
	end
	if not(self.x + self.velX >= 0 and self.x + self.width + self.velX <= love.window.getWidth()) then -- score
		self.x = self.startX
		self.y = self.startY
		self:setVelocity()
	end
	self:move()
end

function Ball:move()
	--X Collision
	if self:checkCollision(paddle, self.x + self.velX, self.y) then
		while not self:checkCollision(paddle, self.x + SIGNUM(self.velX), self.y) do
			self.x = self.x + SIGNUM(self.velX)
		end
		self.velX = self.velX * -1 --bounce only happens with this object
	end
	if self:checkCollision(enemy, self.x + self.velX, self.y) then
		while not self:checkCollision(enemy, self.x + SIGNUM(self.velX), self.y) do
			self.x = self.x + SIGNUM(self.velX)
		end
		self.velX = self.velX * -1 --bounce only happens with this object
	end
	self.x = self.x + self.velX
	--Y Collision
	if self:checkCollision(paddle, self.x, self.y + self.velY) then
		while not self:checkCollision(paddle, self.x, self.y + SIGNUM(self.velY)) do
			self.y = self.y + SIGNUM(self.velY)
		end
		self.velY = self.velY * -1 --bounce only happens with this object
	end
	if self:checkCollision(enemy, self.x, self.y + self.velY) then
		while not self:checkCollision(enemy, self.x, self.y + SIGNUM(self.velY)) do
			self.y = self.y + SIGNUM(self.velY)
		end
		self.velY = self.velY * -1 --bounce only happens with this object
	end
	self.y = self.y + self.velY
end

function Ball:setVelocity()
	if math.random(2) == 1 then self.velX = Ball.SPEED else self.velX = -Ball.SPEED end
	if math.random(2) == 1 then self.velY = Ball.SPEED else self.velY = -Ball.SPEED end
end

function Ball:checkCollision(other, x, y)
	if not(other.collidable == nil) then
		if other.collidable then
			if(x < other.x + other.width and x + self.width > other.x and y < other.y + other.height and y + self.height > other.y) then
				return true;
			end
		end
	end
	return false
end
