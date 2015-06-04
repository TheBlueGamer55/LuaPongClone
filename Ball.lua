Ball = {
--Constants
SPEED = 2.5
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
end

function Ball:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, self.x, self.y)
end

function Ball:update(dt)
	--Keep within window borders
	if self.x + self.velX >= 0 and self.x + self.width + self.velX <= love.window.getWidth() then
		self.x = self.x + self.velX
	else --Out of room
		self.x = self.startX
		self.y = self.startY
		self:setVelocity()
	end
	if self.y + self.velY >= 0 and self.y + self.height + self.velY <= love.window.getHeight() then
		self.y = self.y + self.velY
	else --Out of room
		self.x = self.startX
		self.y = self.startY
		self:setVelocity()
	end
end

function Ball:setVelocity()
	if math.random(2) == 1 then self.velX = Ball.SPEED else self.velX = -Ball.SPEED end
	if math.random(2) == 1 then self.velY = Ball.SPEED else self.velY = -Ball.SPEED end
end
