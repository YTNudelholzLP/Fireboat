debug = true

player = {x = 50, y = 500, speed = 400, img = nil, alive = true, score = 0, level = 1, asteroids = 0 , skin = 1 }
drop = { speed = 250, img = nil, interval = 0.2, intervalTimer = 0, sound = nil}
drops = {}
flame = { speed = 300, img = nil, interval = 3.0, intervalTimer = 0 }
flames = {}
getroffen = {img = nil }
boom = { timer = 25, img = nil, interval = 3.0, intervalTimer = 0, sound = nil }
booms = {}
backgrounds = {}
schwierigkeiten = {}
skin = {}
isMenu = true
isPlaying = false
isGameOver = false
title = {img = nil}
menuOptions = 3
menuOptionWith = 200
menuOptionGutter = (love.graphics.getWidth() - menuOptions * menuOptionWith) / (menuOptions + 1)
menuTable = {}
menuEntrySkin = {x = menuOptionGutter * 1 + (1 - 1) * menuOptionWith,y = 300, width = menuOptionWith, height = 100,
	text = "Skins", offsetx = 50, offsety = 45 }
table.insert(menuTable, menuEntrySkin)
menuEntryStart = {x = menuOptionGutter * 2 + (2 - 1) * menuOptionWith,y = 300, width = menuOptionWith, height = 100,
	text = "Start", offsetx = 50, offsety = 45}
table.insert(menuTable, menuEntryStart)
menuEntryExpert = {x = menuOptionGutter * 3 + (3 - 1) * menuOptionWith,y = 300, width = menuOptionWith, height = 100,
	text = "Expert Mode", offsetx = 50, offsety = 45}
table.insert(menuTable, menuEntryExpert)
levelUp = {  img = nil, timer = 50, x = nil , y = love.graphics.getHeight()/2 }
table.insert(schwierigkeiten, {playerSpeed = 400, flameSpeed = 100, flameInterval = 3.0} ) --level1
table.insert(schwierigkeiten, {playerSpeed = 400, flameSpeed = 120, flameInterval = 2.8} )--level2
table.insert(schwierigkeiten, {playerSpeed = 450, flameSpeed = 150, flameInterval = 2.7} )--level3
table.insert(schwierigkeiten, {playerSpeed = 450, flameSpeed = 170, flameInterval = 2.6} )--level4
table.insert(schwierigkeiten, {playerSpeed = 500, flameSpeed = 200, flameInterval = 2.3} )--level5
table.insert(schwierigkeiten, {playerSpeed = 500, flameSpeed = 220, flameInterval = 2.0} )--level6
table.insert(schwierigkeiten, {playerSpeed = 550, flameSpeed = 240, flameInterval = 1.8} )--level7
table.insert(schwierigkeiten, {playerSpeed = 600, flameSpeed = 250, flameInterval = 1.6} )--level8
table.insert(schwierigkeiten, {playerSpeed = 600, flameSpeed = 270, flameInterval = 1.3} )--level9
table.insert(schwierigkeiten, {playerSpeed = 600, flameSpeed = 300, flameInterval = 1.0} )--level10
table.insert(schwierigkeiten, {playerSpeed = 650, flameSpeed = 500, flameInterval = 0.1} )--der Tod muhahahahahahahahahahaha

function love.load(arg)
	player.img = love.graphics.newImage('assets/Fireboat-klein.png')
	drop.img = love.graphics.newImage('assets/splash-klein.png')
	flame.img = love.graphics.newImage('assets/asteroid.png')
	boom.img = love.graphics.newImage('assets/explosion.png')
	getroffen.img = love.graphics.newImage('assets/Getroffen.png')
	levelUp.img = love.graphics.newImage('assets/level-up.png')
	title.img = love.graphics.newImage('assets/title.png')
	levelUp.x = love.graphics.getWidth()/2 -levelUp.img:getWidth()/2
	levelUp.y = love.graphics.getHeight()/2 -levelUp.img:getHeight()/2 -100
	table.insert(backgrounds, { img = love.graphics.newImage('assets/space-universe background.jpg') })
	table.insert(backgrounds, { img = love.graphics.newImage('assets/level2.jpg') })
	table.insert(backgrounds, { img = love.graphics.newImage('assets/level3.jpg') })
	table.insert(backgrounds, { img = love.graphics.newImage('assets/level4.jpg') })
	backgroundMusic = love.audio.newSource('assets/BackgroundMusic.mp3',"stream")
	backgroundMusic:setLooping(true)
	backgroundMusic:setVolume(0.2)
	gameOverSound = love.audio.newSource('assets/GameOver.wav',"static")
	drop.sound = love.audio.newSource('assets/Tropfen.mp3',"static")
	drop.sound:setVolume(0.5)
	boom.sound = love.audio.newSource('assets/Knall.wav',"static")
	boom.sound:setVolume(0.5)
	applauseSound = love.audio.newSource('assets/Applause.wav',"static")
--	table.insert(backgrounds, { img = love.graphics.newImage('assets/space-universe background.jpg') })
end

function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
		return
			x1 < x2+w2 and
			x2 < x1+w1 and
			y1 < y2+h2 and
			y2 < y1+h1
end
--[[
Wird für jedes Bild aufgerufen
--]]

function love.draw()
	if isMenu then
		for i, menuEntry in ipairs(menuTable) do
			love.graphics.rectangle("line", menuEntry.x, menuEntry.y, menuEntry.width, menuEntry.height)
			love.graphics.print(menuEntry.text,menuEntry.x +  menuEntry.offsetx,menuEntry.y + menuEntry.offsety)
		end
		love.graphics.draw(title.img,love.graphics:getWidth()/2 - title.img:getWidth()/2, 100)
	end
	if isPlaying or isGameOver then
		love.graphics.draw( backgrounds [(player.level -1) % #backgrounds +1 ].img, 0,0)
		for i, drop in ipairs(drops) do
			love.graphics.draw(drop.img, drop.x, drop.y)
		end
		for i, flame in ipairs(flames) do
			love.graphics.draw(flame.img, flame.x, flame.y)
		end
		for i, boom in ipairs(booms) do
			love.graphics.draw(boom.img, boom.x, boom.y)
		end
		if player.alive then
			love.graphics.draw(player.img, player.x, player.y)
		else
			love.graphics.draw(getroffen.img, player.x, player.y)
			love.graphics.print("Drücke 'n' für den Neustart oder 'm' fürs Menü", love.graphics:getWidth()/2-50, love.graphics.getHeight()/2-50)
		end
		love.graphics.print("PUNKTE: ".. tostring(player.score), 10, 10)
		love.graphics.print("LEVEL: ".. tostring(player.level), 10, 25)
	end
end


function love.update(dt)
		if love.keyboard.isDown('escape') then
			love.event.push('quit')
		end

		drop.intervalTimer = drop.intervalTimer - (1 * dt)
		flame.intervalTimer = flame.intervalTimer - (1 * dt)

		for i, drop in ipairs(drops) do
			drop.y = drop.y - (drop.speed * dt)
			if drop.y < 0 then
				table.remove(drops, i)
			end
		end

		if flame.intervalTimer < 0 and player.alive then
			randomX = math.random(10, love.graphics.getWidth() - 10)
			--newFlame = { x = randomX, y = - 10, speed = flame.speed, img = flame.img }
			newFlame = { x = randomX, y = - 10, speed = schwierigkeiten[player.level].flameSpeed, img = flame.img }
			table.insert(flames, newFlame)
		--	flame.intervalTimer = flame.interval
			flame.intervalTimer = schwierigkeiten[player.level].flameInterval
		end

		for i, boom in ipairs(booms) do
			boom.timer = boom.timer - 1
			if boom.timer < 0 then
				table.remove(booms, i)
			end
		end

		for i, flame in ipairs(flames) do
			flame.y = flame.y + (flame.speed * dt)
			if flame.y > love.graphics.getHeight() then
				table.remove(flames, i)
			end
		end

		for i, flame in ipairs(flames) do
			for j, drop in ipairs(drops) do
				if checkCollision(flame.x, flame.y, flame.img:getWidth(), flame.img:getHeight(),
				 drop.x, drop.y, drop.img:getWidth(), drop.img:getHeight()) then
					 table.remove(drops, j)
					 table.remove(flames, i)
					 player.score = player.score +10
					 player.asteroids = player.asteroids +1
					 --	if player.asteroids < 10 then display.newImageRect( "background level1.jpg", display.contentWidth, display.contentHeight)
						--end
					-- newBoom = { x = flame.x + ((drop.x + (drop.img:getWidth() /2)) - (flame.x + (flame.img:getWidth()/2)) /2),
					--  y = flame.y + ((drop.y + (drop.img:getHeight() /2)) - (flame.y + (flame.img:getHeight()/2)) /2),
						newBoom = { x = flame.x, y = flame.y + 60 , timer = boom.timer, img = boom.img }
					 table.insert(booms, newBoom)
			 	   boom.intervalTimer = boom.interval
					 boom.sound:play()
					 if player.asteroids - math.floor(player.asteroids/10) * 10 == 0 then
						 player.level = player.level + 1
						 applauseSound:play()
						 table.insert(booms, {x = levelUp.x, y = levelUp.y, img = levelUp.img, timer = levelUp.timer} )
					 end
		 		end
			end
		end

		for i, flame in ipairs(flames) do
			if checkCollision(flame.x, flame.y, flame.img:getWidth(), flame.img:getHeight(),
				player.x, player.y, player.img:getWidth(), player.img:getHeight())
				and player.alive then
					--table.remove(flames, i)
					for j, flame in ipairs(flames) do
						flames[j] = nil
					end
					player.alive = false
					gameOverSound:play()
			end
		end

		if player.alive then
			if love.keyboard.isDown('left', 'a') then
				player.x = math.max(player.x - (schwierigkeiten[player.level].playerSpeed * dt), 0)
			elseif love.keyboard.isDown('right', 'd') then
				player.x = math.min(player.x + (schwierigkeiten[player.level].playerSpeed * dt),love.graphics.getWidth() - player.img:getWidth())
			elseif love.keyboard.isDown('space') and drop.intervalTimer < 0  then
				newDrop = { x = player.x + (player.img:getWidth()/2), y = player.y, speed = drop.speed, img = drop.img }
				table.insert(drops, newDrop)
				drop.sound:play()
				drop.intervalTimer = drop.interval
			end
		else
		 	if love.keyboard.isDown('n') then
				player.alive = true
				player.score = 0
				player.level = 1
				player.asteroids = 0
				flame.interval = 3.0
			end
			if love.keyboard.isDown('m') then
				isMenu = true
				isPlaying = false
				isGameOver = false
			end
		end

		for i, drop in ipairs(drops) do
			drop.y = drop.y - (drop.speed * dt)
			if drop.y < 0 then
				table.remove(drops, i)
			end
		end
end
function love.mousereleased(x, y, button, istouch)
--	io.write('Mausdrücker x = '..x..' y = '..y)
	if x >= menuEntryStart.x and x <= menuEntryStart.x + menuEntryStart.width and y >= menuEntryStart.y and y <= menuEntryStart.y + menuEntryStart.height then
		player.alive = true
		player.score = 0
		player.level = 1
		player.asteroids = 0
		flame.interval = 3.0
		isMenu = false
		isPlaying = true
		isGameOver = false
		love.audio.play(backgroundMusic)
	elseif x >= menuEntryExpert.x and x <= menuEntryExpert.x + menuEntryExpert.width and y >= menuEntryExpert.y and y <= menuEntryExpert.y + menuEntryExpert.height then
		player.alive = true
		player.score = 0
		player.level = 11
		player.asteroids = 0
		flame.interval = 3.0
		isMenu = false
		isPlaying = true
		isGameOver = false
	end
end
