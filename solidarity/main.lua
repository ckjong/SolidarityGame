


function love.load()

	--code for navigating between maps
	require("scripts/drawfunctions")
	--json for map files
	json = require("json")
	--pathfinding code

	gameStage = 0
--map
	gridsize = 16
	debugView = 0
	infoView = 0
	mapExists = 0
	locationTriggers = {
										overworld = {
											{17*gridsize, 16*gridsize, "gardeningShed", 11*gridsize, 17*gridsize, 1}}, --entrancex, entrancey, name, newplayerx, newplayery, locked (1 = yes)
										gardeningShed = {
											{11*gridsize, 18*gridsize, "overworld", 17*gridsize, 17*gridsize, 0}},
										battlefield1 = {
											{nil, nil, "battlfield1", 3*gridsize, 6*gridsize, 1}}
									}
	currentLocation = "overworld"
	mapPath = {overworld = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\scripts\\map.txt",
	"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\map1.txt"},
	gardeningShed = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\scripts\\map.txt",
	"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\map2.txt"},
	battlefield1 = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\scripts\\map.txt",
	"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\map3.txt"}
}

	mapFile1 = nil
	mapFile2 = nil


--characters
	player = {
		grid_x = 17*gridsize,
		grid_y = 22*gridsize,
		act_x = 17*gridsize,
		act_y = 22*gridsize,
		speed = 48,
		canMove = 1,
		moveDir = 0,
		threshold = 0,
		facing = 2,
		name = "Saffron",
		battlestats = {maxhp = 2, damage = 1, moves = 2},
		inventory = {},
		party = {1, 2}, -- Fennel, Mint
		spells = {},
		next = {{x = 0, y = 0, facing = 0, location = "overworld"}}
	}

	npcs = {{
		grid_x = 18*gridsize,
		grid_y = 30*gridsize,
		act_x = 18*gridsize,
		act_y = 30*gridsize,
		speed = 30,
		canMove = 0,
		moveDir = 0,
		threshold = 0,
		facing = 1, --direction currently facing
		start = 1, --direction facing when starting
		location = "overworld",
		dialogue = 0,
		name = "Fennel",
		status = "worker",
		animationkey = 5, -- where animations start
		n = 1, --stage in single conversation
		c = 1, -- dialogue case
		battlestats = {maxhp = 2, damage = 1, moves = 3},
		next = {{x = 0, y = 0, facing = 1, location = "overworld"}}
		},
		{
			grid_x = 14*gridsize,
			grid_y = 25*gridsize,
			act_x = 14*gridsize,
			act_y = 25*gridsize,
			speed = 30,
			canMove = 0,
			moveDir = 0,
			threshold = 0,
			facing = 1,
			start = 2,
			location = "overworld",
			dialogue = 0,
			name = "Mint",
			status = "worker",
			animationkey = 9,
			n = 1,
			c = 1,
			battlestats = {maxhp = 2, damage = 1, moves = 2},
			next = {{x = 20*gridsize, y = 25*gridsize, facing = 2, location = "overworld"}}
			},
			{
				grid_x = 10*gridsize,
				grid_y = 27*gridsize,
				act_x = 10*gridsize,
				act_y = 27*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 4,
				location = "overworld",
				dialogue = 0,
				name = "Lark",
				status = "boss",
				animationkey = 17, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 5, damage = 1,  moves = 2},
				next = {{x = 10*gridsize, y = 27*gridsize, facing = 4, location = "overworld"}}
			},
			{
				grid_x = 16*gridsize,
				grid_y = 21*gridsize,
				act_x = 16*gridsize,
				act_y = 21*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 4,
				location = "overworld",
				dialogue = 0,
				name = "Finch",
				status = "boss",
				animationkey = 13, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 16*gridsize, y = 21*gridsize, facing = 4, location = "overworld"}}
			}
}

	storedLocation = {x = 0, y = 0}
--battle
	battleMode = 0
	battleGlobal = {maxmoves = #player.party + 2, movesTaken = 0, turn = 0, phase = 0}

	require("scripts/battle")
	--objects
	objects = {
		{16, 17, "GardeningSign"},
		{23, 17, "KitchenSign"},
	 	{29, 26, "DormitorySign"},
		{29, 34, "MixingSign"}
	}
--images
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setColor(0, 0, 0)
	love.graphics.setBackgroundColor(255,255,255)


	bg = {overworld = love.graphics.newImage("images/solidarity_overworld.png"),
				overworldnight = love.graphics.newImage("images/solidarity_overworld_night.png"),
				gardeningShed = love.graphics.newImage("images/gardeningshedbg.png"),
				battlefield1 = love.graphics.newImage("images/solidarity_battletest.png")}
	currentBackground = bg.overworld
	daytime = 1

	--portraits
	portraitsheet1 = love.graphics.newImage("images/solidarity_char_portraits.png")
	portraitkey = {{name = "player", width = 46, height = 46, start = 0},
								 {name = "Fennel", width = 46, height = 46, start = 1*46},
								 {name = "Mint", width = 46, height = 46, start = 2*46},
								 {name = "Cress", width = 46, height = 46, start = 3*46},
								 {name = "Robin", width = 46, height = 46, start = 4*46},
								 {name = "Agave", width = 46, height = 46, start = 5*46},
								 {name = "Finch", width = 46, height = 46, start = 6*46},
								 {name = "Lark", width = 46, height = 46, start = 7*46}
								}
	currentspeaker = "player"

	animsheet1 = love.graphics.newImage("images/solidarity_anim.png")
	ui = {arrowright = love.graphics.newImage("images/utopiaui_0.png"),
		arrowdown = love.graphics.newImage("images/utopiaui_5.png"),
		pressz = love.graphics.newImage("images/utopiaui_6.png"),
		textboxbg = love.graphics.newImage("images/solidarity_textboxfull.png"),
		textboxbottom = love.graphics.newImage("images/solidarity_textboxbottom.png"),
		}
	toptiles = {gardeningShed = love.graphics.newImage("images/utopia_toptiles_0.png")}

--spritesheet, number of tiles in animation, starting position, length, width, height, duration
	animations = {{newAnimation(animsheet1, 0, 4, 16, 16, .6), "player.walkup"},
				 {newAnimation(animsheet1, 1*16, 4, 16, 16, .6), "player.walkdown"},
				 {newAnimation(animsheet1, 2*16, 4, 16, 16, .65), "player.walkleft"},
				 {newAnimation(animsheet1, 3*16, 4, 16, 16, .65), "player.walkright"},
			 	 {newAnimation(animsheet1, 4*16, 4, 16, 16, .6 ), "npcs[1].walkup"},
			   {newAnimation(animsheet1, 5*16, 4, 16, 16, .6 ), "npcs[1].walkdown"},
			 	 {newAnimation(animsheet1, 6*16, 4, 16, 16, .65 ), "npcs[1].walkleft"},
				 {newAnimation(animsheet1, 7*16, 4, 16, 16, .65 ), "npcs[1].walkright"},
				 {newAnimation(animsheet1, 8*16, 4, 16, 16, .6 ), "npcs[2].walkup"},
				 {newAnimation(animsheet1, 9*16, 4, 16, 16, .6 ), "npcs[2].walkdown"},
				 {newAnimation(animsheet1, 10*16, 4, 16, 16, .65 ), "npcs[2].walkleft"},
				 {newAnimation(animsheet1, 11*16, 4, 16, 16, .65 ), "npcs[2].walkright"},
				 {newAnimation(animsheet1, 12*16, 4, 16, 16, .6 ), "npcs[3].walkup"},
				 {newAnimation(animsheet1, 13*16, 4, 16, 16, .6 ), "npcs[3].walkdown"},
				 {newAnimation(animsheet1, 14*16, 4, 16, 16, .65 ), "npcs[3].walkleft"},
				 {newAnimation(animsheet1, 15*16, 4, 16, 16, .65 ), "npcs[3].walkright"},
				 {newAnimation(animsheet1, 16*16, 4, 16, 16, .6 ), "npcs[4].walkup"},
				 {newAnimation(animsheet1, 17*16, 4, 16, 16, .6 ), "npcs[4].walkdown"},
				 {newAnimation(animsheet1, 18*16, 4, 16, 16, .65 ), "npcs[4].walkleft"},
				 {newAnimation(animsheet1, 19*16, 4, 16, 16, .65 ), "npcs[4].walkright"}
			 }

--cutscene
cutsceneControl = {stage = 0, total = 1, current = 1}
-- types: 1 = talk, 2 = changeScene
cutsceneList ={{
	triggered = false,
	type = 1,
	move = true, --does the NPC move?
	npc = 3, --which NPC
	target = player, -- where do they move
	facing = {1}, --what direction are they facing at the end
	noden = 1, --what node are they walking to next
	dialoguekey = 2,
	path = {},
	fadeout = true,
	goback = true, -- npc goes back to starting position
	skipnext = false, -- do we go directly to next cutscene?
	nextStage = true, -- do we go to the next game scene
	switchTime = false -- do we switch from day to night or vice versa
}}


--dialogue
	font = love.graphics.setNewFont("fonts/pixel.ttf", 8)
	dialogueMode = 0
	dialogueStage = 0
	choice = {mode = 0, pos = 1, total = 1, name = "", case = 0, more = 0}
	text = nil
	trigger = {0}

	--dialogue and object descriptions
	require("scripts/dialogue")

--timer for blinking text/images
	timer = {{base = .5, current = 0, trigger = 0},
					 {base = 2, current = 0, trigger = 0}}
--editor for creating new maps and other functions
	require("scripts/mapfunctions")

	--generate map
	mapFile1 = mapPath.overworld[1]
	mapFile2 = mapPath.overworld[2]
	mapGen (bg.overworld, mapFile1, mapFile2)
	--table.save(initTable, "D:\\my game projects\\utopia\\scripts\\initTable.lua")
	require("scripts/dialoguefunctions")
	require("scripts/movefunctions")
	require("scripts/pathfinding")
	require("scripts/cutscenefunctions")
	-- add location of NPCs or other moving obstacles to map collision
	updateMap(npcs)
end


function love.update(dt)

	if checkSpoken(npcs, NPCdialogue[dialogueStage], 5) == true then
		if cutsceneControl.stage == 0 then
			local n = cutsceneControl.current
			if cutsceneList[n].triggered == false then
				print("spoken to everyone")
				cutsceneControl.stage = 1
			end
		end
	end

--run timers for blinking text, patrol, etc.
	for i = 1, #timer do
		if timer[i].current > 0 then
			timer[i].current = timer[i].current - dt
		else
			if timer[i].trigger == 0 then
				timer[i].trigger = 1
			else
			 timer[i].trigger = 0
			end
			timer[i].current = timer[i].base
		end
	end
	--immobilize player if dialoguemode active
	if dialogueMode == 1 then
		player.canMove = 0
	end

if dialogueMode == 0 then
	if trigger[1] == 0 then
		DialogueTrigger(17, 21, 3)
	end
	if player.canMove == 1 then
		if gameStage == 0 then
			moveCharBack(17, 21, 17, 22, 2)
		end
	end
end

--set direction and destination position
	if debugView == 0 then
		updateGrid(player, 1)
	elseif debugView == 1 then
		updateGrid(player, 0)
	end

	player.moveDir, player.act_x, player.act_y = moveChar(player.moveDir, player.act_x, player.grid_x, player.act_y, player.grid_y, (player.speed *dt))

	if player.canMove == 1 then
		changeMap(player.act_x, player.act_y, locationTriggers[currentLocation])
	end

	--animation time update
	for k, v in pairs(animations) do
		animations[k][1]["currentTime"] = animations[k][1]["currentTime"] + dt
    if animations[k][1]["currentTime"] >= animations[k][1]["duration"] then
        animations[k][1]["currentTime"] = animations[k][1]["currentTime"] - animations[k][1]["duration"]
    end
	end

--cutscene triggered, update map
if cutsceneControl.stage == 1 then
	cutsceneStage1Talk()
end

--cutsecene running, move characters
if cutsceneControl.stage == 2 then
	 cutsceneStage2Talk(dt)
end

--cutscene running, trigger dialogue
if cutsceneControl.stage == 3 then
	cutsceneStage3Talk()
end

--cutscene running, return to starting position
if cutsceneControl.stage == 4 and dialogueMode == 0 then
	cutsceneStage4Talk(dt)
end

--cutscene over, reset
if cutsceneControl.stage == 5 and dialogueMode == 0 then
	clearMap(2)
	player.canMove = 1
	if cutsceneList[cutsceneControl.current].triggered == false then
		if cutsceneList[cutsceneControl.current].switchTime == true then
			changeTime()
		end
		changeGameStage()
		cutsceneList[cutsceneControl.current].triggered = true
	end
	if cutsceneControl.current < cutsceneControl.total then -- if there are more cutscenes advance to next one
		cutsceneControl.current = cutsceneControl.current + 1
		cutsceneControl.stage = 0
	else
		cutsceneControl.stage = 6
	end
end

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
	local scale = {x=4, y=4}
	local translate = {x = (width - gridsize*scale.x) / 2, y = (height - gridsize*scale.y) /2}
	love.graphics.push()
	--camera move and scale
	love.graphics.translate(-player.act_x*scale.x + translate.x, -player.act_y*scale.y + translate.y)
	love.graphics.scale( scale.x, scale.y )

	-- draw background
	drawBackground()

	--draw map
	if debugView == 1 then
		love.graphics.setColor(0, 0, 0)
		drawEditor (initTable)
	end

	--draw extra infoView
	if infoView == 1 then
		drawInfo(player.act_x, player.act_y)
	end

	--render player
	love.graphics.setColor(255, 255, 255)
	drawPlayer()

	--render npcs
	drawNPCs()

	-- render tiles on top of player
	if currentLocation == "gardeningShed" then
		drawTop(currentLocation, locationTriggers)
	end

	--render dialogue box and text
	if text ~= nil and dialogueMode == 1 then
		local width = love.graphics.getWidth( )/4
		local height = love.graphics.getHeight( )/4
		local recheight = 32
		local recwidth = width-8
		local xnudge = 12
		local ynudge = 2
		local boxposx = player.act_x - (width/2) + xnudge
		local boxposy = player.act_y + (height/2) - recheight + ynudge
		--render dialogue box
		love.graphics.draw(ui.textboxbg, boxposx, boxposy)
		if dialogueMode == 1 then
			drawPortrait(currentspeaker, boxposx-2, boxposy)
		end
		love.graphics.draw(ui.textboxbottom, boxposx, boxposy)
		--draw z or arrow if more text
		drawArrow()
		--draw arrow for choices, shift text if arrow present
		drawText(boxposx + 52, boxposy + 8)
	end

	--draw UI for battles
	if battleMode == 1 then
		love.graphics.print("turn: " .. battleGlobal.turn .."   phase: " .. battleGlobal.phase, player.act_x - 48, player.act_y - 40)
	end
	love.graphics.pop()
end

-- KEY PRESSES --
---------------
function love.keypressed(key)

--initiate debug/map editing mode
  if key == "p" then
	 	if debugView == 0 then
    	debugView = 1
		elseif debugView == 1 then
			debugView = 0
		end
  end
--print additional info about game on screen for debugging
	if key == "i" then
		if infoView == 0 then
			infoView = 1
		else
			infoView = 0
		end
	end
--- interact with objects or people
  if key == "z" then
		DialogueSetup(npcs, dialogueStage)
		faceObject(player.facing)
	end
-- add block to editor
	if key == "space" and debugView == 1 then
		addBlock (initTable, player.grid_x, player.grid_y, 1) -- editor.lua
	end

	if key == "s" and debugView == 1 then
		saveMap()
	end

	if key == "c" then --trigger cutscene for testing
		if cutsceneControl.stage == 0 then
			cutsceneControl.stage = 1
		else
			print("exit cutscene")
			cutsceneControl.stage = 0
			player.canMove = 1
		end
	end

-- move between dialogue options
	if choice.mode == 1 then
		if key == "down" then
			if choice.pos >= 1 and choice.pos < choice.total then
				choice.pos = choice.pos + 1
				choiceText(NPCdialogue[dialogueStage][choice.name][choice.case].text, choice.pos, choice.total)
			end
		elseif key == "up" then
			if choice.pos > 1 then
				choice.pos = choice.pos - 1
				choiceText(NPCdialogue[dialogueStage][choice.name][choice.case].text, choice.pos, choice.total)
			end
		end
	end

-- end battle
	if battleMode == 1 and key == "escape" then
		battleMode = 0
		battleGlobal.phase = 0
		-- battleEnd(storedLocation.x, storedLocation.y)
	end
end
