


function love.load()



	--code for navigating between maps
	require("scripts/drawfunctions")


	--json for map files
	json = require("json")
	--pathfinding code

	gameStage = 0
	keyInput = 1
--map
	gridsize = 16
	debugView = 0
	infoView = 0
	mapExists = 0
	locationTriggers = {
										overworld = {
											{17*gridsize, 16*gridsize, "gardeningShed", 11*gridsize, 17*gridsize, 0},--entrancex, entrancey, name, newplayerx, newplayery, locked (1 = yes)
											{30*gridsize, 25*gridsize, "dormitory", 12*gridsize, 17*gridsize, 0},
											{34*gridsize, 25*gridsize, "dormitory", 25*gridsize, 17*gridsize, 0},
											{24*gridsize, 16*gridsize, "dininghall", 13*gridsize, 20*gridsize, 0},
											{28*gridsize, 16*gridsize, "dininghall", 23*gridsize, 20*gridsize, 0}},
										gardeningShed = {
											{11*gridsize, 18*gridsize, "overworld", 17*gridsize, 17*gridsize, 0}},
										battlefield1 = {
											{nil, nil, "battlfield1", 3*gridsize, 6*gridsize, 1}},
										dormitory = {
											{12*gridsize, 18*gridsize, "overworld", 30*gridsize, 26*gridsize, 0},
										  {25*gridsize, 18*gridsize, "overworld", 34*gridsize, 26*gridsize, 0}},
										dininghall = {
											{13*gridsize, 21*gridsize, "overworld", 24*gridsize, 17*gridsize, 0},
											{23*gridsize, 21*gridsize, "overworld", 28*gridsize, 17*gridsize, 0}},
									}
	currentLocation = "overworld"
	mapPath = {overworld = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\1overworld.txt"},
	gardeningShed = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\2gardeningShed.txt"},
	battlefield1 = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\3battlefield1.txt"},
	dormitory = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\4dormitory.txt"},
	dininghall = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\5dininghall.txt"},

}

	mapFile1 = nil


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
			},
			{
				grid_x = 21*gridsize,
				grid_y = 25*gridsize,
				act_x = 21*gridsize,
				act_y = 25*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 2,
				location = "overworld",
				dialogue = 0,
				name = "Cress",
				status = "worker",
				animationkey = 21, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory"}}
			},
			{
				grid_x = 17*gridsize,
				grid_y = 16*gridsize,
				act_x = 17*gridsize,
				act_y = 16*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 2,
				location = "dininghall",
				dialogue = 0,
				name = "Agave",
				status = "worker",
				animationkey = 25, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 17*gridsize, y = 16*gridsize, facing = 2, location = "dininghall"}}
			}
}

	storedLocation = {x = 0, y = 0}

-- actions
	actionMode = 0
	actions = {{current = 0, max = 100, rate = 10, x = 0, y = 0, k = 0}
						}
--battle
	battleMode = 0
	battleGlobal = {maxmoves = #player.party + 2, movesTaken = 0, turn = 0, phase = 0}

	require("scripts/battle")
	--object text index
	objects = {overworld = {
		{"GardeningSign", 16*gridsize, 17*gridsize},
		{"KitchenSign", 23*gridsize, 17*gridsize},
	 	{"DormitorySign", 29*gridsize, 26*gridsize},
		{"StoreSign", 29*gridsize, 34*gridsize}}
	}

--images
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setColor(0, 0, 0)
	love.graphics.setBackgroundColor(255,255,255)

	bg = {overworld = love.graphics.newImage("images/solidarity_overworld.png"),
				overworldnight = love.graphics.newImage("images/solidarity_overworld_night.png"),
				gardeningShed = love.graphics.newImage("images/gardeningshedbg.png"),
				battlefield1 = love.graphics.newImage("images/solidarity_battletest.png"),
		  	dormitory = love.graphics.newImage("images/dormitory.png"),
				dininghall = love.graphics.newImage("images/dininghall.png"),}
	currentBackground = bg.overworld
	daytime = 1 -- 1 = day, 2 = evening, 3 = night

	overlays = {evening = love.graphics.newImage("images/evening_overlay.png")}

	--portraits
	portraitsheet1 = love.graphics.newImage("images/solidarity_char_portraits.png")
	portraitsheet1_night = love.graphics.newImage("images/solidarity_char_portraits_night.png")
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
	animsheet1_night = love.graphics.newImage("images/solidarity_anim_night.png")
	ui = {arrowright = love.graphics.newImage("images/utopiaui_0.png"),
		arrowdown = love.graphics.newImage("images/utopiaui_5.png"),
		pressz = love.graphics.newImage("images/utopiaui_6.png"),
		textboxbg = love.graphics.newImage("images/solidarity_textboxfull.png"),
		textboxbottom = love.graphics.newImage("images/solidarity_textboxbottom.png"),
		}

	-- objects that are not part of static background
	movingObjectSheet = love.graphics.newImage("images/solidarity_objects.png")
	movingObjectQuads = {stool = love.graphics.newQuad(0, 0, 16, 16, movingObjectSheet:getDimensions()),
											 platefull = love.graphics.newQuad(1*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantSm = love.graphics.newQuad(2*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantSmBerries = love.graphics.newQuad(3*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantLg = love.graphics.newQuad(4*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantLgBerries = love.graphics.newQuad(5*gridsize, 0, 16, 16, movingObjectSheet:getDimensions())
											}
	movingObjectData = {overworld = {{"plantSmBerries", 11*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 12*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 13*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 14*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 15*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 18*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 19*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 20*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 21*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 22*gridsize, 23*gridsize, 1},
																		{"plantSmBerries", 11*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 12*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 13*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 14*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 15*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 18*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 19*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 20*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 21*gridsize, 26*gridsize, 1},
																		{"plantSmBerries", 22*gridsize, 26*gridsize, 1},
																		{"plantLgBerries", 11*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 12*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 13*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 14*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 15*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 18*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 19*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 20*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 21*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 22*gridsize, 29*gridsize, 1},
																		{"plantLgBerries", 11*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 12*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 13*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 14*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 15*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 18*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 19*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 20*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 21*gridsize, 32*gridsize, 1},
																		{"plantLgBerries", 22*gridsize, 32*gridsize, 1}
																	 },
											 dininghall = {{"stool", 12*gridsize, 16*gridsize, 1},
											 							{"stool", 13*gridsize, 16*gridsize, 1}
																		}
											}

	-- tiles that are rendered on top of the player and npcs
	toptilesSheet = love.graphics.newImage("images/solidarity_toptiles.png")
	toptiles = {doorway = love.graphics.newQuad(0, 0, 16, 16, toptilesSheet:getDimensions()),
							black = love.graphics.newQuad(1*gridsize, 0, 16, 16, toptilesSheet:getDimensions())
							}
	toptileData = {gardeningShed = {{"doorway", locationTriggers.gardeningShed[1][1], locationTriggers.gardeningShed[1][2], 1}
																 },
								dormitory = {{"doorway", locationTriggers.dormitory[1][1], locationTriggers.dormitory[1][2], 1},
														 {"doorway", locationTriggers.dormitory[2][1], locationTriggers.dormitory[2][2], 1}
													 	},
							  dininghall = {{"doorway", locationTriggers.dininghall[1][1], locationTriggers.dininghall[1][2], 1},
														  {"doorway", locationTriggers.dininghall[2][1], locationTriggers.dininghall[2][2], 1}
													 	 }
								}

--- animated objects
	animsheet2 = love.graphics.newImage("images/solidarity_object_anim.png")
	objectAnimations = {{anim = newAnimation(animsheet2, 0, 4, 16, 16, .4), "plantSmBerries", loop = 1, current = 0, running = 0},
				 							{anim = newAnimation(animsheet2, 1*16, 4, 16, 16, .4), "plantLgBerries", loop = 1, current = 0, running = 0}}


--spritesheet, number of tiles in animation, starting position, length, width, height, duration
	animations = {{anim = newAnimation(animsheet1, 0, 4, 16, 16, .6), name = "player.walkup", loop = 0}, -- loop = 0 is infinite loop
				 {anim = newAnimation(animsheet1, 1*16, 4, 16, 16, .6), name = "player.walkdown", loop = 0},
				 {anim = newAnimation(animsheet1, 2*16, 4, 16, 16, .65), name = "player.walkleft", loop = 0},
				 {anim = newAnimation(animsheet1, 3*16, 4, 16, 16, .65), name = "player.walkright", loop = 0},
			 	 {anim = newAnimation(animsheet1, 4*16, 4, 16, 16, .6 ), name = "npcs[1].walkup", loop = 0},
			   {anim = newAnimation(animsheet1, 5*16, 4, 16, 16, .6 ), name = "npcs[1].walkdown", loop = 0},
			 	 {anim = newAnimation(animsheet1, 6*16, 4, 16, 16, .65 ), name = "npcs[1].walkleft", loop = 0},
				 {anim = newAnimation(animsheet1, 7*16, 4, 16, 16, .65 ), name = "npcs[1].walkright", loop = 0},
				 {anim = newAnimation(animsheet1, 8*16, 4, 16, 16, .6 ), name = "npcs[2].walkup", loop = 0},
				 {anim = newAnimation(animsheet1, 9*16, 4, 16, 16, .6 ), name = "npcs[2].walkdown", loop = 0},
				 {anim = newAnimation(animsheet1, 10*16, 4, 16, 16, .65 ), name = "npcs[2].walkleft", loop = 0},
				 {anim = newAnimation(animsheet1, 11*16, 4, 16, 16, .65 ), name = "npcs[2].walkright", loop = 0},
				 {anim = newAnimation(animsheet1, 12*16, 4, 16, 16, .6 ), name = "npcs[3].walkup", loop = 0},
				 {anim = newAnimation(animsheet1, 13*16, 4, 16, 16, .6 ), name = "npcs[3].walkdown", loop = 0},
				 {anim = newAnimation(animsheet1, 14*16, 4, 16, 16, .65 ), name = "npcs[3].walkleft", loop = 0},
				 {anim = newAnimation(animsheet1, 15*16, 4, 16, 16, .65 ), name = "npcs[3].walkright", loop = 0},
				 {anim = newAnimation(animsheet1, 16*16, 4, 16, 16, .6 ), name = "npcs[4].walkup", loop = 0},
				 {anim = newAnimation(animsheet1, 17*16, 4, 16, 16, .6 ), name = "npcs[4].walkdown", loop = 0},
				 {anim = newAnimation(animsheet1, 18*16, 4, 16, 16, .65 ), name = "npcs[4].walkleft", loop = 0},
				 {anim = newAnimation(animsheet1, 19*16, 4, 16, 16, .65 ), name = "npcs[4].walkright", loop = 0},
				 {anim = newAnimation(animsheet1, 20*16, 4, 16, 16, .6 ), name = "npcs[5].walkup", loop = 0},
				 {anim = newAnimation(animsheet1, 21*16, 4, 16, 16, .6 ), name = "npcs[5].walkdown", loop = 0},
				 {anim = newAnimation(animsheet1, 22*16, 4, 16, 16, .65 ), name = "npcs[5].walkleft", loop = 0},
				 {anim = newAnimation(animsheet1, 23*16, 4, 16, 16, .65 ), name = "npcs[5].walkright", loop = 0},
				 {anim = newAnimation(animsheet1, 24*16, 4, 16, 16, .6 ), name = "npcs[6].walkup", loop = 0},
				 {anim = newAnimation(animsheet1, 25*16, 4, 16, 16, .6 ), name = "npcs[6].walkdown", loop = 0},
				 {anim = newAnimation(animsheet1, 26*16, 4, 16, 16, .65 ), name = "npcs[6].walkleft", loop = 0},
				 {anim = newAnimation(animsheet1, 27*16, 4, 16, 16, .65 ), name = "npcs[6].walkright", loop = 0}
			 }
	--fading
	fading = {on = false, type = 1, start = 0, goal = 0, rate = 0, a = 0, countdown = 0, triggered = 0} -- type 1 = fade in from 0 to 255; 2 = fade out from 255 to 0
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
		fadeout = 1,
		black = 1,
		goback = true, -- npc goes back to starting position
		skipnext = false, -- do we go directly to next cutscene?
		nextStage = true, -- do we go to the next game scene
		switchTime = 1 -- what time of day is it after the end
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
					 {base = 3, current = 0, trigger = 0}}
--editor for creating new maps and other functions
	require("scripts/mapfunctions")

	--generate map
	mapFile1 = mapPath.overworld[1]
	mapGen (bg.overworld, mapFile1)
	--table.save(initTable, "D:\\my game projects\\utopia\\scripts\\initTable.lua")
	require("scripts/dialoguefunctions")
	require("scripts/movefunctions")
	require("scripts/pathfinding")
	require("scripts/cutscenefunctions")
	require("scripts/actionfunctions")
	-- add location of NPCs or other moving obstacles to map collision
	updateMap(npcs)
end


function love.update(dt)

	if checkSpoken(npcs, NPCdialogue[dialogueStage], 6) == true then
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

	-- initiate dialogue and move character back if they enter a location
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

	--run through countdown
	fadeCountdown(dt)

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
	animUpdate(animations, dt)
	animUpdate(objectAnimations, dt)


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

	-- start fade out
	if cutsceneControl.stage == 5 then
		cutsceneStage5Talk()
	end

-- waiting for fade to finish
	if cutsceneControl.stage == 6 then
		cutsceneStage6Talk(dt)

	end

	--cutscene over, reset
	if cutsceneControl.stage == 7 and dialogueMode == 0 then
		cutsceneStage7Talk()
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
	love.graphics.setBlendMode("alpha")
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

	drawTop(currentLocation, movingObjectData, movingObjectSheet, movingObjectQuads)
	if actionMode == 1 then
		drawObjAnims(objectAnimations, actions[1].k, actions[1].x, actions[1].y)
	end

	--draw extra infoView
	if infoView == 1 then
		drawInfo(player.act_x, player.act_y)
	end

	--render player
	love.graphics.setColor(255, 255, 255)
	drawPlayer(animations)


	--render npcs
	drawNPCs(animations)
	-- render tiles on top of player
	if currentLocation ~= "overworld" then
		drawTop(currentLocation, toptileData, toptilesSheet, toptiles)
	end

	-- add multiply screen for evening
 	-- multiplyLayer(width, height)


	--render dialogue box and text
	if text ~= nil and dialogueMode == 1 then
		love.graphics.setColor(255, 255, 255)
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
			if daytime == 0 and currentLocation == "overworld" then
				drawPortrait(currentspeaker, boxposx-2, boxposy, portraitsheet1_night)
			else
				drawPortrait(currentspeaker, boxposx-2, boxposy, portraitsheet1)
			end
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

	--fading
	if fading.on == true then
		fadeBlack(fading.a, width, height)
	end

	--black screen
	if fading.countdown > 0 then
		fadeBlack(255, width, height)
	end

	love.graphics.pop()
end

-- KEY PRESSES --
---------------
function love.keypressed(key)
	if keyInput == 1 then
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
			faceObject(player.facing, objects.overworld)
			faceObject(player.facing, movingObjectData[currentLocation])
			if actionMode == 1 then
				resetAnims(objectAnimations, actions[1].k)
			end
		end
	-- add block to editor
		if key == "space" and debugView == 1 then
			addBlock (initTable, player.grid_x, player.grid_y, 1) -- editor.lua
		end

		if key == "s" and debugView == 1 then
			saveMap()
		end

		if key == "k" then
			if daytime == 1 then
				daytime = 3
				currentBackground = bg.overworldnight
			else
				daytime = 1
				currentBackground = bg.overworld
			end
		end

		if key == "c" then --trigger cutscene for testing
			if cutsceneControl.stage == 0 then
				cutsceneControl.stage = 1
			else
				print("exit cutscene")
				cutsceneControl.stage = 8
				player.canMove = 1
			end
		end

		if key == "l" then
			changeGameStage()
			print("gameStage: " .. gameStage)
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
		if battleMode == 1 and key == "q" then
			battleMode = 0
			battleGlobal.phase = 0
			-- battleEnd(storedLocation.x, storedLocation.y)
		end
	end
	if key == "escape" then
	 	love.event.quit()
	end
end
