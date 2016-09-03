debug = true

player = {x = 50, y = 500, speed = 400, alive = false, score = 0, level = 1, asteroids = 0 , skin = 1 }
drop = { speed = 250, interval = 0.2, intervalTimer = 0, sound = nil}
drops = {}
flame = { speed = 300, interval = 3.0, intervalTimer = 0 }
flames = {}
getroffen = {img = nil }
boom = { timer = 25, img = nil, interval = 3.0, intervalTimer = 0, sound = nil }
booms = {}
schwierigkeiten = {}
skin = {playerImg = nil, dropImg = nil, flameImg = nil, backgrounds = {} }
skin1 = {playerImg = nil, dropImg = nil, flameImg = nil, backgrounds = {} }
skin2 = {playerImg = nil, dropImg = nil, flameImg = nil, backgrounds = {} }
skin3 = {playerImg = nil, dropImg = nil, flameImg = nil, backgrounds = {} }
isLoading = true
isMenu = false
isSkins = false
isPlaying = false
isGameOver = false
--isWinning = false
title = {img = nil}
progressBar = {img = nil, timeToLive = 5, percentComplete = 0, bars = 10, gutter = 7}

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

skinOptions = 3
skinOptionWith = 200
skinOptionGutter = (love.graphics.getWidth() - skinOptions * skinOptionWith) / (skinOptions + 1)
skinTable = {}
skin1Entry = {x = skinOptionGutter * 1 + (1 - 1) * skinOptionWith,y = 300, width = skinOptionWith, height = 100,
	text = "Skin 1", offsetx = 50, offsety = 45 }
table.insert(skinTable, skin1Entry)
skin2Entry = {x = skinOptionGutter * 2 + (2 - 1) * skinOptionWith,y = 300, width = skinOptionWith, height = 100,
	text = "Skin 2", offsetx = 50, offsety = 45}
	skin3Entry = {x = skinOptionGutter * 3 + (3 - 1) * skinOptionWith,y = 300, width = skinOptionWith, height = 100,
		text = "Skin 3", offsetx = 50, offsety = 45}
table.insert(skinTable, skin2Entry)
table.insert(skinTable, skin3Entry)
levelUp = {  img = nil, timer = 50, x = nil , y = love.graphics.getHeight()/2 }

for i = 0, 30 do
	table.insert(schwierigkeiten,
		{playerSpeed = 400 + i * 10,
		flameSpeed = 100 + i * 10,
 		flameInterval = 3 - i * 0.1})
end
table.insert(schwierigkeiten, {playerSpeed = 700, flameSpeed = 700, flameInterval = 0.1} )--level31

function love.load(arg)
	skin1.playerImg = love.graphics.newImage('Skin1/Player.png')
	skin1.dropImg = love.graphics.newImage('Skin1/Drop.png')
	skin1.flameImg = love.graphics.newImage('Skin1/Flame.png')
	skin1.backgroundMusic = love.audio.newSource('skin1/BackgroundMusic.mp3',"stream")
	skin2.playerImg = love.graphics.newImage('Skin2/Player.png')
	skin2.dropImg = love.graphics.newImage('Skin2/Drop.png')
	skin2.flameImg = love.graphics.newImage('Skin2/Flame.png')
	skin2.backgroundMusic = love.audio.newSource('skin2/ElectricTandem.mp3',"stream")
	skin3.playerImg = love.graphics.newImage('skin3/Player.png')
	skin3.dropImg = love.graphics.newImage('skin3/Drop.png')
	skin3.flameImg = love.graphics.newImage('skin3/Flame.png')
	skin3.backgroundMusic = love.audio.newSource('skin3/Jazztalk.mp3',"stream")
	boom.img = love.graphics.newImage('assets/explosion.png')
	getroffen.img = love.graphics.newImage('assets/Getroffen.png')
	--gewonnen.img = love.graphics.newImage('assets/Gewonnen.png')
	levelUp.img = love.graphics.newImage('assets/level-up.png')
	title.img = love.graphics.newImage('assets/title.png')
	progressBar.img = love.graphics.newImage('assets/progressBar.png')
	levelUp.x = love.graphics.getWidth()/2 -levelUp.img:getWidth()/2
	levelUp.y = love.graphics.getHeight()/2 -levelUp.img:getHeight()/2 -100
	table.insert(skin1.backgrounds, { img = love.graphics.newImage('skin1/level1.jpg') })
	table.insert(skin1.backgrounds, { img = love.graphics.newImage('skin1/level2.jpg') })
	table.insert(skin1.backgrounds, { img = love.graphics.newImage('skin1/level3.jpg') })
	table.insert(skin1.backgrounds, { img = love.graphics.newImage('skin1/level4.jpg') })
	table.insert(skin2.backgrounds, { img = love.graphics.newImage('skin2/level1.png') })
	table.insert(skin2.backgrounds, { img = love.graphics.newImage('skin2/level2.jpg') })
	table.insert(skin2.backgrounds, { img = love.graphics.newImage('skin2/level3.jpg') })
	table.insert(skin3.backgrounds, { img = love.graphics.newImage('skin3/level1.jpg') })
	table.insert(skin3.backgrounds, { img = love.graphics.newImage('skin3/level2.png') })
	table.insert(skin3.backgrounds, { img = love.graphics.newImage('skin3/level3.jpg') })
	backgroundMusic = love.audio.newSource('assets/SloMo.mp3',"stream")
	backgroundMusic:setLooping(true)
	backgroundMusic:setVolume(0.2)
	gameOverSound = love.audio.newSource('assets/GameOver.wav',"static")
	drop.sound = love.audio.newSource('assets/Tropfen.mp3',"static")
	drop.sound:setVolume(0.5)
	boom.sound = love.audio.newSource('assets/Knall.wav',"static")
	boom.sound:setVolume(0.5)
	applauseSound = love.audio.newSource('assets/Applause.wav',"static")
	love.audio.play(backgroundMusic)
	skin = skin1
end

function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
		return
			x1 < x2+w2 and
			x2 < x1+w1 and
			y1 < y2+h2 and
			y2 < y1+h1
end

function drawProgressBar()
	x = love.graphics:getWidth()/2 - progressBar.img:getWidth()/2
	y = love.graphics:getHeight()/2 - progressBar.img:getHeight()/2
	love.graphics.draw(progressBar.img, x, y)
	ox = x + 88
	oy = y + 83
	width = progressBar.img:getWidth() - 2 * 88
	height = progressBar.img:getHeight() - 2 * 83
	boxWidth = (width - (progressBar.bars - 1) * progressBar.gutter) / progressBar.bars
	boxHeight = 177
	for i = 0, progressBar.bars - 1 do
		if i / (progressBar.bars - 1) <= progressBar.percentComplete / 100 then
			love.graphics.setColor(117, 231, 0, 255)
		else
			love.graphics.setColor(93, 27, 27, 255)
		end
		love.graphics.rectangle("fill", ox + i * (boxWidth + progressBar.gutter), oy, boxWidth, boxHeight)
	end
end

function love.draw()
	if isMenu then
		love.graphics.draw(title.img,love.graphics:getWidth()/2 - title.img:getWidth()/2, 100)
	end

	if isLoading then
		drawProgressBar()
	end
	love.graphics.setColor(255, 255, 255, 255)
	if isMenu then
		for i, menuEntry in ipairs(menuTable) do
			love.graphics.rectangle("line", menuEntry.x, menuEntry.y, menuEntry.width, menuEntry.height)
			love.graphics.print(menuEntry.text,menuEntry.x +  menuEntry.offsetx,menuEntry.y + menuEntry.offsety)
		end

	end

	if isSkins then
		for i, skinEntry in ipairs(skinTable) do
			love.graphics.rectangle("line", skinEntry.x, skinEntry.y, skinEntry.width, skinEntry.height)
			love.graphics.print(skinEntry.text,skinEntry.x +  skinEntry.offsetx,skinEntry.y + skinEntry.offsety)
		end
		love.graphics.draw(title.img,love.graphics:getWidth()/2 - title.img:getWidth()/2, 100)
	end

	if isPlaying or isGameOver then
		local background = skin.backgrounds [(player.level -1) % #skin.backgrounds +1 ].img
		love.graphics.draw( background, 0,0, 0, love.graphics:getWidth()/background:getWidth(),  love.graphics:getHeight()/background:getHeight())
		for i, drop in ipairs(drops) do
			love.graphics.draw(skin.dropImg, drop.x, drop.y)
		end
		for i, flame in ipairs(flames) do
			love.graphics.draw(skin.flameImg, flame.x, flame.y)
		end
		for i, boom in ipairs(booms) do
			love.graphics.draw(boom.img, boom.x, boom.y)
		end
		if player.alive then
			love.graphics.draw(skin.playerImg, player.x, player.y)
		else
			love.graphics.draw(getroffen.img, player.x, player.y)
			love.graphics.print("Drücke 'n' für den Neustart oder 'm' fürs Menü", love.graphics:getWidth()/2-50, love.graphics.getHeight()/2-50)
		end
		love.graphics.print("PUNKTE: ".. tostring(player.score), 10, 10)
		love.graphics.print("LEVEL: ".. tostring(player.level), 10, 25)
	end
	--if player.level = 32 then
	--	love.graphics.draw(gewonnen.img)
end


function love.update(dt)
		if love.keyboard.isDown('escape') then
			love.event.push('quit')
		end

		drop.intervalTimer = drop.intervalTimer - (1 * dt)
		flame.intervalTimer = flame.intervalTimer - (1 * dt)
		if isLoading then
			if progressBar.percentComplete <= 100 then
				progressBar.percentComplete =	progressBar.percentComplete + dt / progressBar.timeToLive * 100
			else
				isLoading = false
				isMenu = true
			end
		end

		for i, drop in ipairs(drops) do
			drop.y = drop.y - (drop.speed * dt)
			if drop.y < 0 then
				table.remove(drops, i)
			end
		end

		if flame.intervalTimer < 0 and player.alive then
			randomX = math.random(10, love.graphics.getWidth() - 10)
			newFlame = { x = randomX, y = - 10, speed = schwierigkeiten[player.level].flameSpeed, img = flame.img }
			table.insert(flames, newFlame)
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
				if checkCollision(flame.x, flame.y, skin.flameImg:getWidth(), skin.flameImg:getHeight(),
				 drop.x, drop.y, skin.dropImg:getWidth(), skin.dropImg:getHeight()) then
					 table.remove(drops, j)
					 table.remove(flames, i)
					 player.score = player.score +10
					 player.asteroids = player.asteroids +1
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
			if checkCollision(flame.x, flame.y, skin.flameImg:getWidth(), skin.flameImg:getHeight(),
				player.x, player.y, skin.playerImg:getWidth(), skin.playerImg:getHeight())
				and player.alive then
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
				player.x = math.min(player.x + (schwierigkeiten[player.level].playerSpeed * dt),love.graphics.getWidth() - skin.playerImg:getWidth())
			elseif love.keyboard.isDown('space') and drop.intervalTimer < 0  then
				newDrop = { x = player.x + (skin.playerImg:getWidth()/2), y = player.y, speed = drop.speed, img = drop.img }
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


function isButtonClicked(menuItem, x, y)
	 	return x >= menuItem.x and x <= menuItem.x + menuItem.width and y >= menuItem.y and y <= menuItem.y + menuItem.height
end


function love.mousereleased(x, y, button, istouch)
	if isMenu and isButtonClicked( menuEntrySkin, x, y) then
			isMenu = false
			isSkins = true
	--Start
elseif isMenu and isButtonClicked( menuEntryStart, x, y) then
		player.alive = true
		player.score = 0
		player.level = 1
		player.asteroids = 0
		flame.interval = 3.0
		isMenu = false
		isSkins = false
		isPlaying = true
		isGameOver = false
		love.audio.stop()
		skin.backgroundMusic:play()
	--expert Mode
elseif isMenu and isButtonClicked( menuEntryExpert, x, y) then
		player.alive = true
		player.score = 0
		player.level = 31
		player.asteroids = 0
		flame.interval = 3.0
		isMenu = false
		isSkins = false
		isPlaying = true
		isGameOver = false
	--expert Mode
elseif isSkins and isButtonClicked( skin1Entry, x, y) then
	isMenu = true
	isSkins = false
	skin = skin1

elseif isSkins and isButtonClicked( skin2Entry, x, y) then
	isMenu = true
	isSkins = false
	skin = skin2

elseif isSkins and isButtonClicked( skin3Entry, x, y) then
	isMenu = true
	isSkins = false
	skin = skin3

	end
end
