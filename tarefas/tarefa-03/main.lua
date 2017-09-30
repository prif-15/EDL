larguraTela = love.graphics.getWidth()
alturaTela = love.graphics.getHeight()

function love.load()

nave = {
	x = larguraTela/2,
	y = alturaTela/2,
	velocidade = 300
}

 imagem = love.graphics.newImage("nave.jpg")
 love.mouse.setVisible(false)
end

function movimento(dt)
	
	nave.x = love.mouse.getX()
	nave.y = love.mouse.getY()

			
	if love.keyboard.isDown("right") then
		if nave.x < (larguraTela - imagem:getWidth()/2) then
			nave.x = nave.x + nave.velocidade*dt
			love.mouse.setX(nave.x)
			love.mouse.setY(nave.y)
		end
	end
	
	if love.keyboard.isDown("left") then
		if nave.x > (0 + imagem:getWidth()/2) then
			nave.x = nave.x - nave.velocidade*dt
			love.mouse.setX(nave.x)
			love.mouse.setY(nave.y)
		end
	end
	
	if love.keyboard.isDown("up") then
		if nave.y > (0 + imagem:getHeight()/2) then
			nave.y = nave.y - nave.velocidade*dt
			love.mouse.setX(nave.x)
			love.mouse.setY(nave.y)
		end
	end
	
	if love.keyboard.isDown("down") then
		if nave.y < (alturaTela - imagem:getHeight()/2) then
			nave.y = nave.y + nave.velocidade*dt
			love.mouse.setX(nave.x)
			love.mouse.setY(nave.y)
		end	
	end

end

function love.draw()
	love.graphics.setBackgroundColor(255, 255, 255)
	love.graphics.draw(imagem, nave.x, nave.y, 0, 1, 1, imagem:getWidth()/2, imagem:getHeight()/2 )
end

function love.update(dt)
	movimento(dt)
end