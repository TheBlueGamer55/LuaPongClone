Player = {}

--Constructor
function Player:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

--Initialize all fields
function Player:initialize(x, y)
	self.x = x
	self.y = y
	self.sprite = love.graphics.newImage("res/bat_medium.png")
	self.width = self.sprite:getWidth()
	self.height = self.sprite:getHeight()
	self.velX = 0;
	self.velY = 0;
end

function Player:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, self.x, self.y)
end

function Player:update(dt)
	--Movement
	self.velX = 0
	self.velY = 0
	self:move(dt)
	--Keep within window borders
	if self.x + self.velX >= 0 and self.x + self.width + self.velX <= love.window.getWidth() then
		self.x = self.x + self.velX
	end
	if self.y + self.velY >= 0 and self.y + self.height + self.velY <= love.window.getHeight() then
		self.y = self.y + self.velY
	end
end

function Player:move(dt)
	if love.keyboard.isDown("w") then self.velY = -4 end
	if love.keyboard.isDown("s") then self.velY = 4 end
end
