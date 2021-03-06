
function love.load()


	--code for navigating between maps
	require("scripts/drawfunctions")


	--json for map files
	json = require("json")
	--data for save file
	require("data/gamedata")
	require("data/mapdata")

	--dialogue and object descriptions
	require("scripts/dialoguefunctions")

	-- other scripts
	require("scripts/movefunctions")
	require("scripts/pathfinding")
	require("scripts/cutscenefunctions")
	require("scripts/actionfunctions")
	require("scripts/menufunctions")

-- dialogue
	require("data/dialogue")

--editor for creating new maps and other functions
	require("scripts/mapfunctions")

	--generate maps

	for k, v in pairs(locationList) do
		print(v)
		currentLocation = v
		mapGen (bg[v], v)
		clearMap(2)
		saveMap()
	end
	currentLocation = "overworld"
	mapGen (bg[currentLocation], currentLocation)
	--table.save(initTable, "D:\\my game projects\\utopia\\scripts\\initTable.lua")

	-- add location of NPCs or other moving obstacles to map collision
	npcActSetup()
	menuW, menuH = 14*gridsize, 7*gridsize
	canvas = love.graphics.newCanvas(menuW, menuH)
	formBox(menuW, menuH, canvas)
	canvasTitle = love.graphics.newCanvas(menuW, menuH)
	formBox(menuW, menuH, canvasTitle)
	menuW2, menuH2 = 12*gridsize, 8*gridsize
	canvas2 = love.graphics.newCanvas(menuW2, menuH2)
	formBox(menuW2, menuH2, canvas2)
	canvas3 = love.graphics.newCanvas(32, 64) -- box for support select
	formBox(32, 64, canvas3)
	lockDialogue(locationTriggers.overworld)
	setTitleScreen(1)
	music.overworld:setLooping( true )

	movingObjectAnims = createAnimations(movingObjectData.overworld, movingObjectAnimParams)

	for k, v in pairs(sfx) do
		sfx[k]:setVolume(masterVolume * effectVolume)
	end
	sfx.textSelect:setVolume(masterVolume * 0.35)
	for k, v in pairs(music) do
		music[k]:setVolume(masterVolume * musicVolume)
	end
	-- music.overworld:play()

	love.mouse.setVisible(false)
	love.window.setFullscreen(true, "exclusive")
	scale.x, scale.y = getScale()
	fillSaveTable()
end




function love.update(dt)
	player.newDir = 0
	cutsceneTrigger()

	--run timers for blinking text

	if dialogueMode == 1 then
		timerBlink(dt, 1)

	-- run timer for scrolling text
		timerText(dt, 2)
	else
		if player.sleep == true and currentLocation == "dormitory" then
			timerBlink(dt, 1)
		end
		if gameStage == 1 and currentLocation == "overworld" then
			timerBlink(dt, 1)
		end
	end

	if menuView == 1 or titleScreen == 1 then
		timerBlink(dt, 1)
	end
	--immobilize player if dialoguemode active
	if dialogueMode == 1 then
		if player.canMove == 1 then
			player.canMove = 0
		end
	end

	-- do checks for each work stage
	workStageUpdate(dt)

	-- initiate dialogue and move character back if they enter a location

	if dialogueMode == 0 then
		if trigger[1] == 0 then
			DialogueTrigger(17, 21, 3)
		else
			keyInput = 0
		end
		if player.canMove == 1 and currentLocation == "overworld" then
			if workStage == 1 or workStage == 2 then
				moveCharBack(17, 21, 17, 22, 2)
			elseif workStage == 3 then
				if objectInventory.barrelSmBerries + objectInventory.barrelLgBerries < 60 then
					moveCharBack(17, 21, 17, 22, 2)
				else
					local i = "Finch"
					if npcs[i].c == 3 then
						moveCharBack(17, 21, 17, 20, 1)
					elseif npcs[i].c == 4 then
						moveCharBack(17, 21, 17, 22, 2)
					end
				end
			end
		end
	end
	--what to do when player enters area
	areaTriggers()

	--run through countdown
	fadeCountdown(dt)
	-- turn of key inputs
	if wait.triggered == 1 then
		inputWait(wait.n, dt)
	end
--set direction and destination position
	if debugView == 0 then
		if keyInput == 1 then
			updateGrid(player, 1)
		end
	elseif debugView == 1 then
		updateGrid(player, 0)
	end
	--update player move direction and actual position
	player.moveDir, player.act_x, player.act_y = moveChar(player.moveDir, player.act_x, player.grid_x, player.act_y, player.grid_y, (player.speed *dt))

	for j = 1, #player.party do
		local i = player.party[j]
		if npcs[i] ~= nil then
			if j == 1 then
				partyFollows(dt, i, player)
			else
				local d = player.party[j-1]
				partyFollows(dt, i, npcs[d])
			end
			npcs[i].moveDir, npcs[i].act_x, npcs[i].act_y = moveChar(npcs[i].moveDir, npcs[i].act_x, npcs[i].grid_x, npcs[i].act_y, npcs[i].grid_y, (player.speed *dt))
		end
	end

	--check if player enters location change trigger, update currentlocation
	if player.canMove == 1 then
		changeMap(player.act_x, player.act_y, locationTriggers[currentLocation])
	end
	if dialogueMode == 0 and menuView == 0 then
		if cutsceneControl.stage < 1 then
			if time == 1 and currentLocation == "overworld" then
				for k, v in pairs(npcs) do
					if npcs[k].location == "overworld" and npcs[k].randomturn == 1 then
						npcs[k].timer.ct = randomFacing(npcs[k], npcs[k].timer.mt, npcs[k].timer.ct, dt)
					end
				end
			end
		end
	end

	--animation time update
	if player.moveDir ~= 0 then
		animUpdate(charanimations.player.walk, dt, player.moveDir)
	end
	if charanimations.player.act[player.facing].running == 1 then
		animUpdate(charanimations.player.act, dt, player.facing)
	end



	for k, v in pairs(npcs) do
		if menuView == 0 then
			if npcs[k].dialogue == 0 then
				npcActUpdate(dt, k)
				if player.leaveParty == true then
					if npcs[k].leaveControl ~= nil then
						if npcs[k].leaveControl.moving == 1 then
							print("followPath " .. npcs[k].name)
							followPath(npcs[k], dt, npcs[k].leaveControl.n)
						end
					end
				end
				if npcs[k].working == 1 then
					if charanimations[k].act[npcs[k].start].running == 0 then
						charanimations[k].act[npcs[k].start].running = 1
					end
					animUpdate(charanimations[k].act, dt, npcs[k].start)
					if movingObjectData[currentLocation] ~= nil then
						testNpcObject(npcs[k].start, npcs[k].grid_x, npcs[k].grid_y, movingObjectData[currentLocation], k, true, movingObjectAnims[currentLocation])
					end
				else
					animUpdate(charanimations[k].walk, dt, npcs[k].facing)
				end
			end
		end
	end

	if movingObjectAnims[currentLocation] ~= nil then
		for k, v in pairs(movingObjectAnims[currentLocation]) do
			for l, m in pairs(movingObjectAnims[currentLocation][k]) do
				if movingObjectAnims[currentLocation][k][l].running == 1 then
					animUpdate(movingObjectAnims[currentLocation][k], dt, l, k)
				end
			end
		end
	end


	bubbleUpdate(bubble.timer, dt)

	freezeControl()
	runCutscene(dt)


	--battlemode
	if battleMode == 1 and battleGlobal.phase == 0 then
		battleStart()
		battleGlobal.phase = 1
	end
end


-- DRAW --
---------------

function love.draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local translate = {x = (width - gridsize*scale.x) / 2, y = (height - gridsize*scale.y) /2}
	love.graphics.push()
	love.graphics.setBlendMode("alpha")
	--camera move and scale
	love.graphics.translate(-player.act_x*scale.x + translate.x, -player.act_y*scale.y + translate.y)
	love.graphics.scale( scale.x, scale.y )
	-- love.graphics.setShader(multiply)
	-- draw background
	drawBackground()

	--draw map
	if debugView == 1 then
		love.graphics.setColor(0, 0, 0)
		drawEditor (initTable)
	end

	-- draw tiles on top of player
	-- drawStillObjects(currentLocation, movingObjectData, animsheet3, movingObjectQuads)
	drawStillObjects(currentLocation, nonInteractiveObjects, animsheet3, movingObjectQuads)
	if menuView == 0 then
		if movingObjectData[currentLocation] ~= nil then
			for k, v in pairs(movingObjectData[currentLocation]) do
				for i = 1, #movingObjectData[currentLocation][k] do
					if movingObjectAnims[currentLocation][k] ~= nil then
						drawActAnims(movingObjectAnims[currentLocation][k], i, movingObjectData[currentLocation][k][i].x, movingObjectData[currentLocation][k][i].y)
					else
						print("movingObjectData not mirrored " .. k)
					end
				end
			end
		end
	end


	--draw extra infoView
	if infoView == 1 then
		drawInfo(player.act_x, player.act_y)
	end

	--render npcs
	for k, v in pairs(npcs) do
		drawNPCs(charanimations[k].walk, k)
	end

	--render player
	drawPlayer(charanimations.player.walk)
	-- render tiles on top of player
	if currentLocation ~= "overworld" then
		drawStillObjects(currentLocation, toptileData, toptilesSheet, toptiles)
	end

	if dialogueMode == 0 and menuView == 0 then
		drawWorldUI()
	end

	if bubble.on == 1 then
		drawBubble(bubble.x, bubble.y, bubble.obj)
	end

	if menuView == 1 then
		drawMenu(player.act_x, player.act_y, menu.currentTab)
	end
	--render dialogue box and text
	if text ~= nil and dialogueMode == 1 then
		local recheight = 32
		local recwidth = 232
		local xnudge = width/2
		local ynudge = 1*scale.y
		local boxposx = player.act_x + gridsize/2 - recwidth/2
		local boxposy = player.act_y + gridsize/2 + (height/scale.y)/2 - recheight - ynudge
		 -- - recheight + ynudge


		--render dialogue box
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(ui.textboxbg, boxposx, boxposy -2)

		--draw name of character speaking and text box
		drawName(boxposx + 48, boxposy - 12, currentspeaker)


		drawPortrait(currentspeaker, boxposx-2, boxposy, portraitsheet1)

		love.graphics.draw(ui.textboxbottom, boxposx, boxposy - 2)
		--draw z or arrow if more text
		drawArrow(boxposx, boxposy, scale.y, recwidth, choice.mode, choice.pos, choice.total)
		--draw arrow for choices, shift text if arrow present
		drawText(boxposx + 52, boxposy + 8, scale.x, recwidth)
	end

	--draw UI for battles
	if battleMode == 1 then
		love.graphics.print("turn: " .. battleGlobal.turn .."   phase: " .. battleGlobal.phase, player.act_x - 48, player.act_y - 40)
	end

	drawMeters(player.act_x - width/scale.x/2 + 16, player.act_y-76)
	drawTime(player.act_x + width/scale.x/2 - 32, player.act_y-76)
	--fading
	if fading.on == true then
		fadeBlack(fading.a, width, height)
	end

	--black screen
	if fading.countdown > 0 then
		fadeBlack(255, width, height)
	end

	if titleScreen == 1 then
		local width, height = love.graphics.getDimensions()
		local boxX = player.act_x + gridsize/2 - menuW/2
		local boxY = player.act_y - 48
		local recheight = 32
		local recwidth = 232
		local xnudge = width/2
		local ynudge = 1*scale.y
		local boxposx = player.act_x + gridsize/2 - recwidth/2
		local boxposy = player.act_y + gridsize/2 + (height/scale.y)/2 - recheight - ynudge
		drawTitleScreen(width, height, boxX, boxY)
		drawTitleUI(boxX + 8, boxY  + 94, titleScreenOptions.save.current, titleScreenOptions.load.current)
		if titleScreenOptions.load.select == true then
			drawArrow(boxposx, boxposy, scale.y, recwidth, 1, titleScreenOptions.load.current, #saves)
		end
	end

	love.graphics.pop()
end

function love.textinput(t)
  addNotes(t)
	if titleScreen == 1 then
		if titleScreenOptions.save.current == 3 and titleScreenOptions.save.select == true then
			inputSaveName(t)
		end
	end
end

-- KEY PRESSES --
---------------
function love.keypressed(key)

	if noteMode == 0 and titleScreenOptions.save.nameinput == false then
		if keyInput == 1 then
		--- interact with objects or people
		  if key == "z" then
				print("pressed z")
				textn = 0
				if menuView == 0 then
					if titleScreen == 0 then
						if usedItem == 1 then
							afterItemUse()
						end
						if storedIndex[1] ~= 0 then
							DialogueSetup(npcs, dialogueStage, storedIndex[1])
						else
							DialogueSetup(npcs, dialogueStage)
						end
						faceObject(player, player.facing, staticObjects[currentLocation]) -- still objects
						faceObject(player, player.facing, movingObjectData[currentLocation])
						faceObject(player, player.facing, locationTriggers[currentLocation])
					else
						if titleScreenOptions.save.nameinput == false then
							if titleScreenOptions.load.select == true then
								local filename = saves[titleScreenOptions.load.current]
								unpackSaveTables(filename)
								setTitleScreen(0)
							end
							if titleScreenOptions.save.current == 1 then
								quitGame("restart")
							elseif titleScreenOptions.save.current == 2 then
								titleScreenOptions.load.select = true
							elseif titleScreenOptions.save.current == 3 then
								titleScreenOptions.save.select = true
							end
						end
					end
				else
					 menuHierarchy(key)
				end
				print("dialogueMode after z" .. dialogueMode)
			end

		-- move between dialogue or menu options

		if key == "down" or key == "up" then
			if menuView ~= 1 then
				if choice.mode == 1 then
					local tbl = {}
					if choice.type == "npc" then
						tbl = NPCdialogue[dialogueStage][choice.name][choice.case].text
					elseif choice.type == "yesno" then
						print ("yes no text: " .. objectText.yesno.text[choice.pos])
						tbl = objectText.yesno.text
					end
					choiceChange(key, tbl)
				end
				if titleScreen == 1 then
					if titleScreenOptions.load.select == true then
						titleScreenOptions.load.current = titleSelect(key, titleScreenOptions.load.current, #saves, "v")
					end
				end
			else
				if menu.currentTab == "inventory" then
					inventorySelect(key, #player.inventory, menu.currentTab)
				elseif menu.currentTab == "map1" then
					inventorySelect(key, #socialMap, menu.currentTab)
				end
			end
		end
		if key == "left" or key == "right" then
			if menuView == 1 then
				if menu.position[1] == 1 then
					menu.currentTab = switchTabs(key)
				elseif menu.position[1] > 1 then
					if menu.currentTab == "map1" then
						inventorySelect(key, #socialMap, menu.currentTab)
					end
					if menu.position[1] == 2 then
						if menu.currentTab == "inventory" then
							inventorySelect(key, #player.inventory, menu.currentTab)
						end
					end
				end
			else
				if titleScreen == 1 then
					if titleScreenOptions.save.nameinput == false and titleScreenOptions.load.select == false then
						titleScreenOptions.save.current = titleSelect(key, titleScreenOptions.save.current, titleScreenOptions.save.max, "h") -- horizontal
					end
				end
			end
		end


		-- end battle
			if battleMode == 1 and key == "q" then
				battleMode = 0
				battleGlobal.phase = 0
				-- battleEnd(storedLocation.x, storedLocation.y)
			end
		end
		--end keyInput, keys below can be pressed any time

		if key == "x" then
			if menuView == 0 then
				exitAction()
				if dialogueMode == 1 then
					print("textn " .. textn)
					textn = 200
					keyInput = 1
				else
					if titleScreen == 1 then
						setTitleScreen(0)
					end
				end
			else
				menuHierarchy(key)
			end
		end

		if key == "f11" then
			local fullscreen, fstype = love.window.getFullscreen( )
			if fullscreen == false then
				love.mouse.setVisible(false)
				love.window.setFullscreen(true, "exclusive")
				scale.x, scale.y = getScale()
			else
				love.mouse.setVisible(true)
				love.window.setFullscreen(false, "exclusive")
				scale.x, scale.y = getScale()
			end
		end

		if key == "escape" then
			if menuView == 0 then
				if titleScreen == 0 then
					if dialogueMode == 0 then
						setTitleScreen(1)
					end
				else
					if titleScreenOptions.load.select == false then
						setTitleScreen(0)
					else
						titleScreenOptions.load.select = false
					end
				end
			else
				if menu.position[1] ~= 3 then
					menuEscape()
				end
			end
		end

		if key == "q" then
			quitGame("quit")
		end

		if key == "i" then
			openMenu("inventory")
		end

		if key == "j" then
			if menu.tabNum >= 3 then
				openMenu("map1")
			end
		end
	-- ====CHEAT KEYS===
	-- initiate debug/map editing mode
	--   if key == "p" then
	-- 	 	if debugView == 0 then
	--     	debugView = 1
	-- 		elseif debugView == 1 then
	-- 			debugView = 0
	-- 		end
	-- 		if infoView == 0 then
	-- 			infoView = 1
	-- 		else
	-- 			infoView = 0
	-- 		end
	--   end
	--
	-- -- add block to editor
	-- 	if key == "space" and debugView == 1 then
	-- 		addBlock(initTable, player.grid_x, player.grid_y, 1) -- editor.lua
	-- 	end
	--
	-- 	if key == "s" then
	-- 		if debugView == 1 then
	-- 			saveMap()
	-- 		else
	-- 			if dialogueMode == 0 then
	-- 				local name = "test1"
	-- 				createSaveFile(name)
	-- 				print("saved game: " .. name)
	-- 			end
	-- 		end
	-- 	end
	--
	-- 	if key == "t" then
	-- 		local name = "test1"
	-- 		unpackSaveTables(name)
	-- 		print("loaded game: " .. name)
	-- 	end
	--
	--
	-- 	if key == "c" then --trigger cutscene for testing
	-- 		if cutsceneControl.stage == 0 then
	-- 			cutsceneControl.stage = 1
	-- 		else
	-- 			print("exit cutscene")
	-- 			cutsceneControl.stage = 8
	-- 			player.canMove = 1
	-- 		end
	-- 	end
	--
	-- 	if key == "1" then
	-- 		player.energy = 100
	-- 	end
	--
	-- 	if key == "0" then
	-- 		player.energy = 0
	-- 	end
	--
	-- 	if key == "6" then
	-- 		addRemoveItem("You got 60 Plum Berries", "Plum Berries", 60, "plantSmBerries")
	-- 	end
	--
	-- 	if key == "9" then
	-- 		for k, v in pairs(npcs) do
	-- 			table.insert(socialMap, npcs[k])
	-- 			npcs[k].mapping.added = 1
	-- 		end
	-- 		menu.tabNum = 3
	-- 	end
	--
	-- 	if key == "l" then
	-- 		changeGameStage()
	-- 		cutsceneControl.current = cutsceneControl.current + 1
	-- 		cutsceneControl.stage = 0
	-- 		print("gameStage: " .. gameStage)
	-- 	end
-- ====END CHEAT KEYS===
	end
	if titleScreen == 1 then
		finishSaveName(key)
	end
	if menuView == 1 then
		removeNotes(key)
	end

end
