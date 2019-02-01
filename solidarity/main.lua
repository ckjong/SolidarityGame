


function love.load()


	--code for navigating between maps
	require("scripts/drawfunctions")


	--json for map files
	json = require("json")
	--pathfinding code

	gameStage = 0
	keyInput = 1
	freeze = {action = 0, dialogue = 0} -- 2 = stage freeze, 1 = energy too low, 0 = no freeze
--map
	gridsize = 16
	debugView = 0
	infoView = 0
	menuView = 0
	mapExists = 0
	tempBlocks = {overworld = {
														{x = 17, y = 20, on = 1},
														{x = 16, y = 21, on = 0},
														{x = 17, y = 21, on = 0}
													}
			}
	locationTriggers = {
										overworld = {
											{x = 17*gridsize, y = 16*gridsize, name = "gardeningShed", x2 = 11*gridsize, y2 = 17*gridsize, locked = 1},--entrancex, entrancey, name, newplayerx, newplayery, locked (1 = yes)
											{x = 30*gridsize, y = 25*gridsize, name = "dormitory", x2 = 12*gridsize, y2 = 17*gridsize, locked = 0},
											{x = 34*gridsize, y = 25*gridsize, name = "dormitory", x2 = 25*gridsize, y2 = 17*gridsize, locked = 0},
											{x = 24*gridsize, y = 16*gridsize, name = "dininghall", x2 = 13*gridsize, y2 = 20*gridsize, locked = 0},
											{x = 28*gridsize, y = 16*gridsize, name = "dininghall", x2 = 23*gridsize, y2 = 20*gridsize, locked = 0},
											{x = 30*gridsize, y = 33*gridsize, name = "store", x2 = 17*gridsize, y2 = 19*gridsize, locked = 1}},
										gardeningShed = {
											{x = 11*gridsize, y = 18*gridsize, name = "overworld", x2 = 17*gridsize, y2 = 17*gridsize, locked = 0}},
										battlefield1 = {
											{x = nil, y = nil, name = "battlfield1", x2 = 3*gridsize, y2 = 6*gridsize, locked = 1}},
										dormitory = {
											{x = 12*gridsize, y = 18*gridsize, name = "overworld", x2 = 30*gridsize, y2 = 26*gridsize, locked = 0},
										  {x = 25*gridsize, y = 18*gridsize, name = "overworld", x2 = 34*gridsize, y2 = 26*gridsize, locked = 0}},
										dininghall = {
											{x = 13*gridsize, y = 21*gridsize, name = "overworld", x2 = 24*gridsize, y2 = 17*gridsize, locked = 0},
											{x = 23*gridsize, y = 21*gridsize, name = "overworld", x2 = 28*gridsize, y2 = 17*gridsize, locked = 0}},
										store = {
												{x = 17*gridsize, y = 20*gridsize, name = "overworld", x2 = 30*gridsize, y2 = 34*gridsize, locked = 0}}
									}
	locationList = {"overworld", "gardeningShed", "dormitory", "dininghall", "store"}
	currentLocation = "overworld"
	currentJournal = {}

	mapPath = {overworld = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\1overworld.txt"},
	gardeningShed = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\2gardeningShed.txt"},
	battlefield1 = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\3battlefield1.txt"},
	dormitory = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\4dormitory.txt"},
	dininghall = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\5dininghall.txt"},
	store = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\6store.txt"}

}

	mapFile1 = nil


	--images
		love.graphics.setDefaultFilter("nearest", "nearest")
		love.graphics.setColor(0, 0, 0)
		love.graphics.setBackgroundColor(255,255,255)

		-- scale for graphics
		scale = {x=4, y=4}

		bg = {overworld = love.graphics.newImage("images/solidarity_overworld.png"),
					overworldnight = love.graphics.newImage("images/solidarity_overworld_night.png"),
					gardeningShed = love.graphics.newImage("images/gardeningshedbg.png"),
					battlefield1 = love.graphics.newImage("images/solidarity_battletest.png"),
			  	dormitory = love.graphics.newImage("images/dormitory.png"),
					dininghall = love.graphics.newImage("images/dininghall.png"),
					store = love.graphics.newImage("images/store.png"),
				}
		currentBackground = bg.overworld
		time = 1 -- 1 = day, 2 = evening, 3 = night
		day = 1

		worldmap1 = love.graphics.newImage("images/solidarity_map2.png")
		overlays = {evening = love.graphics.newImage("images/evening_overlay.png")}

		--portraits
		portraitsheet1 = love.graphics.newImage("images/solidarity_char_portraits.png")
		portraitkey = {{name = "player", width = 46, height = 46, start = 0},
									 {name = "Fennel", width = 46, height = 46, start = 1*46},
									 {name = "Mint", width = 46, height = 46, start = 2*46},
									 {name = "Cress", width = 46, height = 46, start = 3*46},
									 {name = "Tarragon", width = 46, height = 46, start = 4*46},
									 {name = "Agave", width = 46, height = 46, start = 5*46},
									 {name = "Finch", width = 46, height = 46, start = 6*46},
									 {name = "Lark", width = 46, height = 46, start = 7*46},
									 {name = "Robin", width = 46, height = 46, start = 8*46},
									 {name = "Durian", width = 46, height = 46, start = 9*46},
									 {name = "Brier", width = 46, height = 46, start = 10*46},
									 {name = "Yarrow", width = 46, height = 46, start = 11*46},
									 {name = "Kousa", width = 46, height = 46, start = 12*46},
									 {name = "Tulsi", width = 46, height = 46, start = 14*46}
									}
		currentspeaker = "player"


		ui = {arrowup = love.graphics.newImage("images/solidarity_ui_00.png"),
			arrowdown = love.graphics.newImage("images/solidarity_ui_01.png"),
			arrowright = love.graphics.newImage("images/solidarity_ui_02.png"),
			arrowleft = love.graphics.newImage("images/solidarity_ui_03.png"),
			pressz = love.graphics.newImage("images/solidarity_ui_04.png"),
			cornerLTop = love.graphics.newImage("images/solidarity_ui_09.png"),
			cornerRTop = love.graphics.newImage("images/solidarity_ui_10.png"),
			cornerLBottom = love.graphics.newImage("images/solidarity_ui_11.png"),
			cornerRBottom = love.graphics.newImage("images/solidarity_ui_12.png"),
		 	itembg = love.graphics.newImage("images/solidarityui_16x16_14.png"),
			textboxbg = love.graphics.newImage("images/solidarity_textboxfull.png"),
			textboxbottom = love.graphics.newImage("images/solidarity_textboxbottom.png"),
			energyicon = love.graphics.newImage("images/solidarityui_16x16_00.png"),
			energytextbg = love.graphics.newImage("images/solidarityui_16x16_01.png"),
			energytextbground = love.graphics.newImage("images/solidarityui_16x16_02.png"),
			energyboltlg = love.graphics.newImage("images/solidarityui_16x16_03.png"),
			energyboltsm = love.graphics.newImage("images/solidarityui_16x16_04.png"),
			energytextbgcircle = love.graphics.newImage("images/solidarityui_16x16_05.png"),
			energytextbgsmleft = love.graphics.newImage("images/solidarityui_16x16_06.png"),
			energytextbgsmright = love.graphics.newImage("images/solidarityui_16x16_07.png"),
			timeiconbgday = love.graphics.newImage("images/solidarityui_16x16_08.png"),
			timeiconbgevening = love.graphics.newImage("images/solidarityui_16x16_09.png"),
			timeiconbgnight = love.graphics.newImage("images/solidarityui_16x16_10.png"),
			timeiconday = love.graphics.newImage("images/solidarityui_16x16_11.png"),
			timeiconevening = love.graphics.newImage("images/solidarityui_16x16_12.png"),
			timeiconnight = love.graphics.newImage("images/solidarityui_16x16_13.png"),
			namebgL = love.graphics.newImage("images/solidarityui_16x16_15.png"),
			namebgM = love.graphics.newImage("images/solidarityui_16x16_16.png"),
			namebgR = love.graphics.newImage("images/solidarityui_16x16_17.png"),
			}
		boxTilesSheet = love.graphics.newImage("images/solidarity_box_tiles.png")

		boxTilesQuads = {fill = {{love.graphics.newQuad(0, 0, 16, 16, boxTilesSheet:getDimensions()),
															love.graphics.newQuad(1*16, 0, 16, 16, boxTilesSheet:getDimensions()),
															love.graphics.newQuad(2*16, 0, 16, 16, boxTilesSheet:getDimensions())},
															{love.graphics.newQuad(0, 1*16, 16, 16, boxTilesSheet:getDimensions()),
															love.graphics.newQuad(1*16, 1*16, 16, 16, boxTilesSheet:getDimensions()),
															love.graphics.newQuad(2*16, 1*16, 16, 16, boxTilesSheet:getDimensions())},
															{love.graphics.newQuad(0, 2*16, 16, 16, boxTilesSheet:getDimensions()),
															love.graphics.newQuad(1*16, 2*16, 16, 16, boxTilesSheet:getDimensions()),
															love.graphics.newQuad(2*16, 2*16, 16, 16, boxTilesSheet:getDimensions())}
														},
										line = {{love.graphics.newQuad(0, 3*16, 16, 16, boxTilesSheet:getDimensions()),
														love.graphics.newQuad(1*16, 3*16, 16, 16, boxTilesSheet:getDimensions()),
														love.graphics.newQuad(2*16, 3*16, 16, 16, boxTilesSheet:getDimensions())},
														{love.graphics.newQuad(0, 4*16, 16, 16, boxTilesSheet:getDimensions()),
														love.graphics.newQuad(1*16, 4*16, 16, 16, boxTilesSheet:getDimensions()),
														love.graphics.newQuad(2*16, 4*16, 16, 16, boxTilesSheet:getDimensions())},
														{love.graphics.newQuad(0, 2*16, 5*16, 16, boxTilesSheet:getDimensions()),
														love.graphics.newQuad(1*16, 5*16, 16, 16, boxTilesSheet:getDimensions()),
														love.graphics.newQuad(2*16, 5*16, 16, 16, boxTilesSheet:getDimensions())}
													}
										}

		boxMap = {}

		menu = {currentTab = "inventory", allTabs = {"inventory", "map2", "journal", "map1", }, position = {1, 1, 1}, total = 3, tabNum = 2}

		-- objects that are not part of static background
		animsheet3 = love.graphics.newImage("images/solidarity_objects.png")
		movingObjectQuads = {stool = love.graphics.newQuad(0, 0, 16, 16, animsheet3:getDimensions()),
												 platefull = love.graphics.newQuad(1*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 plantSm = love.graphics.newQuad(2*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 plantSmBerries = love.graphics.newQuad(3*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 plantLg = love.graphics.newQuad(4*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 plantLgBerries = love.graphics.newQuad(5*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 barrelSmBerries = love.graphics.newQuad(6*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 barrelLgBerries = love.graphics.newQuad(7*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 platefull2 = love.graphics.newQuad(8*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 fenceopenL = love.graphics.newQuad(9*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 fenceopenR = love.graphics.newQuad(10*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 fenceclosedL = love.graphics.newQuad(11*gridsize, 0, 16, 16, animsheet3:getDimensions()),
												 fenceclosedR = love.graphics.newQuad(12*gridsize, 0, 16, 16, animsheet3:getDimensions())
												}

animsheet1 = love.graphics.newImage("images/solidarity_anim.png")
animsheet_act = love.graphics.newImage("images/solidarity_anim_act.png")
--characters
	player = {
		grid_x = 17*gridsize,
		grid_y = 23*gridsize,
		act_x = 17*gridsize,
		act_y = 23*gridsize,
		speed = 48,
		canMove = 1,
		moveDir = 0,
		threshold = 0,
		facing = 2,
		name = "Saffron",
		battlestats = {maxhp = 2, damage = 1, moves = 2},
		inventory = {},
		maxInventory = 8,
		party = {1, 2}, -- Fennel, Mint
		spells = {},
		energy = 100,
		next = {{x = 0, y = 0, facing = 0, location = "overworld"},
						{x = 0, y = 0, facing = 0, location = "dininghall"}},
		animations = {walk = {{anim = newAnimation(animsheet1, 0, 4, 16, 16, .6), name = "up", loop = 0},
													{anim = newAnimation(animsheet1, 1*16, 4, 16, 16, .6), name = "down", loop = 0},
													{anim = newAnimation(animsheet1, 2*16, 4, 16, 16, .65), name = "left", loop = 0},
													{anim = newAnimation(animsheet1, 3*16, 4, 16, 16, .65), name = "right", loop = 0}},
					act = {{anim = newAnimation(animsheet_act, 0, 4, 16, 16, .6), name = "up", loop = 1, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 1*16, 4, 16, 16, .6), name = "down", loop = 1, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 2*16, 4, 16, 16, .6), name = "left", loop = 1, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 3*16, 4, 16, 16, .6), name = "right", loop = 1, current = 0, running = 0, count = 0}}
				}
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
		randomturn = 0, --randomly faces different directions
		working = 1, -- use action anims
		canWork = 1,
		timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
		location = "overworld",
		dialogue = 0,
		name = "Fennel",
		status = "worker",
		animationkey = 5, -- where animations start
		n = 1, --stage in single conversation
		c = 1, -- dialogue case
		battlestats = {maxhp = 2, damage = 1, moves = 3},
		next = {{x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
						{x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0}},
		animations = {walk = {{anim = newAnimation(animsheet1, 4*16, 4, 16, 16, .6 ), name = "up", loop = 0},
													{anim = newAnimation(animsheet1, 5*16, 4, 16, 16, .6 ), name = "down", loop = 0},
													{anim = newAnimation(animsheet1, 6*16, 4, 16, 16, .65 ), name = "left", loop = 0},
													{anim = newAnimation(animsheet1, 7*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
						act = {{anim = newAnimation(animsheet_act, 4*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
						{anim = newAnimation(animsheet_act, 5*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
						{anim = newAnimation(animsheet_act, 6*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
						{anim = newAnimation(animsheet_act, 7*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
					}
		},
		{
			grid_x = 13*gridsize,
			grid_y = 23*gridsize,
			act_x = 13*gridsize,
			act_y = 23*gridsize,
			speed = 30,
			canMove = 0,
			moveDir = 0,
			threshold = 0,
			facing = 1,
			start = 2,
			randomturn = 0, --randomly faces different directions
			working = 1, -- use action anims
			canWork = 1,
			timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
			location = "overworld",
			dialogue = 0,
			name = "Mint", --2
			status = "worker",
			animationkey = 9,
			n = 1,
			c = 1,
			battlestats = {maxhp = 2, damage = 1, moves = 2},
			next = {{x = 21*gridsize, y = 23*gridsize, facing = 2, location = "overworld", canWork = 1},
							{x = 21*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0}},
			animations = {walk = {{anim = newAnimation(animsheet1, 8*16, 4, 16, 16, .6 ), name = "up", loop = 0},
														{anim = newAnimation(animsheet1, 9*16, 4, 16, 16, .6 ), name = "down", loop = 0},
														{anim = newAnimation(animsheet1, 10*16, 4, 16, 16, .65 ), name = "left", loop = 0},
														{anim = newAnimation(animsheet1, 11*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
							act = {{anim = newAnimation(animsheet_act, 8*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
							{anim = newAnimation(animsheet_act, 9*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
							{anim = newAnimation(animsheet_act, 10*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
							{anim = newAnimation(animsheet_act, 11*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
						}
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
				randomturn = 0,
				working = 0,
				canWork = 0,
				timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
				location = "overworld",
				dialogue = 0,
				name = "Finch", --4
				status = "boss",
				animationkey = 13, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 16*gridsize, y = 21*gridsize, facing = 4, location = "overworld", canWork = 0},
								{x = 16*gridsize, y = 20*gridsize, facing = 4, location = "overworld", canWork = 0}},
				animations = {walk = {{anim = newAnimation(animsheet1, 12*16, 4, 16, 16, .6 ), name = "up", loop = 0},
															{anim = newAnimation(animsheet1, 13*16, 4, 16, 16, .6 ), name = "down", loop = 0},
															{anim = newAnimation(animsheet1, 14*16, 4, 16, 16, .65 ), name = "left", loop = 0},
															{anim = newAnimation(animsheet1, 15*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
								act = {{anim = newAnimation(animsheet_act, 12*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 13*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 14*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 15*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
							}
			},
			{
				grid_x = 10*gridsize,
				grid_y = 27*gridsize,
				act_x = 10*gridsize,
				act_y = 27*gridsize,
				speed = 30,
				canMove = 1,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 4,
				randomturn = 1,
				working = 0,
				canWork = 0,
				timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
				location = "overworld",
				dialogue = 0,
				name = "Lark", -- 3
				status = "boss",
				animationkey = 17, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 5, damage = 1,  moves = 2},
				next = {{x = 10*gridsize, y = 27*gridsize, facing = 4, location = "overworld", canWork = 0},
								{x = 0, y = 0, facing = 0, location = "offscreen", canWork = 0}},
				animations = {walk = {{anim = newAnimation(animsheet1, 16*16, 4, 16, 16, .6 ), name = "up", loop = 0},
															{anim = newAnimation(animsheet1, 17*16, 4, 16, 16, .6 ), name = "down", loop = 0},
															{anim = newAnimation(animsheet1, 18*16, 4, 16, 16, .65 ), name = "left", loop = 0},
															{anim = newAnimation(animsheet1, 19*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
								act = {{anim = newAnimation(animsheet_act, 16*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 17*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 18*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 19*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
							}
			},
			{
				grid_x = 21*gridsize,
				grid_y = 26*gridsize,
				act_x = 21*gridsize,
				act_y = 26*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 1,
				randomturn = 0,
				working = 0,
				canWork = 0,
				timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
				location = "overworld",
				dialogue = 0,
				name = "Cress", -- 5
				status = "worker",
				animationkey = 21, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
								{x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0}},
				animations = {walk = {{anim = newAnimation(animsheet1, 20*16, 4, 16, 16, .6 ), name = "up", loop = 0},
															{anim = newAnimation(animsheet1, 21*16, 4, 16, 16, .6 ), name = "down", loop = 0},
															{anim = newAnimation(animsheet1, 22*16, 4, 16, 16, .65 ), name = "left", loop = 0},
															{anim = newAnimation(animsheet1, 23*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
								act = {{anim = newAnimation(animsheet_act, 20*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 21*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 22*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 23*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
							}
			},
			{
				grid_x = 13*gridsize,
				grid_y = 31*gridsize,
				act_x = 13*gridsize,
				act_y = 31*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 2,
				randomturn = 0,
				working = 0,
				canWork = 0,
				timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
				location = "overworld",
				dialogue = 0,
				name = "Agave", --6
				status = "worker",
				animationkey = 25, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 18*gridsize, y = 19*gridsize, facing = 2, location = "dininghall", canWork = 0},
								{x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0}},
				animations = {walk = {{anim = newAnimation(animsheet1, 24*16, 4, 16, 16, .6 ), name = "up", loop = 0},
															{anim = newAnimation(animsheet1, 25*16, 4, 16, 16, .6 ), name = "down", loop = 0},
															{anim = newAnimation(animsheet1, 26*16, 4, 16, 16, .65 ), name = "left", loop = 0},
															{anim = newAnimation(animsheet1, 27*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
								act = {{anim = newAnimation(animsheet_act, 24*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 25*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 26*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 27*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
							}
			},
			{
				grid_x = 21*gridsize,
				grid_y = 31*gridsize,
				act_x = 21*gridsize,
				act_y = 31*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 2,
				randomturn = 0,
				working = 0,
				canWork = 0,
				timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
				location = "overworld",
				dialogue = 0,
				name = "Tarragon", --7
				status = "worker",
				animationkey = 29, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 26*gridsize, y = 16*gridsize, facing = 2, location = "dormitory", canWork = 0},
								{x = 26*gridsize, y = 16*gridsize, facing = 2, location = "dormitory", canWork = 0}},
				animations = {walk = {{anim = newAnimation(animsheet1, 28*16, 4, 16, 16, .6 ), name = "up", loop = 0},
															{anim = newAnimation(animsheet1, 29*16, 4, 16, 16, .6 ), name = "down", loop = 0},
															{anim = newAnimation(animsheet1, 30*16, 4, 16, 16, .65 ), name = "left", loop = 0},
															{anim = newAnimation(animsheet1, 31*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
								act = {{anim = newAnimation(animsheet_act, 28*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 29*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 30*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 31*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
							}
			},
			{
				grid_x = 14*gridsize,
				grid_y = 27*gridsize,
				act_x = 14*gridsize,
				act_y = 27*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 2,
				randomturn = 0,
				working = 0,
				canWork = 0,
				timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
				location = "overworld",
				dialogue = 0,
				name = "Robin", --8
				status = "worker",
				animationkey = 33, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 28*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
								{x = 28*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0}},
				animations = {walk = {{anim = newAnimation(animsheet1, 32*16, 4, 16, 16, .6 ), name = "up", loop = 0},
															{anim = newAnimation(animsheet1, 33*16, 4, 16, 16, .6 ), name = "down", loop = 0},
															{anim = newAnimation(animsheet1, 34*16, 4, 16, 16, .65 ), name = "left", loop = 0},
															{anim = newAnimation(animsheet1, 35*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
								act = {{anim = newAnimation(animsheet_act, 32*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 33*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 34*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 35*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
							}
			},
			{
				grid_x = 0*gridsize,
				grid_y = 0*gridsize,
				act_x = 0*gridsize,
				act_y = 0*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 2,
				randomturn = 0,
				working = 0,
				canWork = 0,
				timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc., current time, max time, wait time
				location = "offscreen",
				dialogue = 0,
				name = "Durian", --9
				status = "worker",
				animationkey = 37, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 27*gridsize, y = 14*gridsize, facing = 4, location = "dormitory", canWork = 0},
								{x = 27*gridsize, y = 14*gridsize, facing = 4, location = "dormitory", canWork = 0}},
				animations = {walk = {{anim = newAnimation(animsheet1, 36*16, 4, 16, 16, .6 ), name = "up", loop = 0},
															{anim = newAnimation(animsheet1, 37*16, 4, 16, 16, .6 ), name = "down", loop = 0},
															{anim = newAnimation(animsheet1, 38*16, 4, 16, 16, .65 ), name = "left", loop = 0},
															{anim = newAnimation(animsheet1, 39*16, 4, 16, 16, .65 ), name = "right", loop = 0}},
								act = {{anim = newAnimation(animsheet_act, 36*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 37*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 38*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
								{anim = newAnimation(animsheet_act, 39*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
							}
			}
}

	storedLocation = {x = 0, y = 0}
	storedIndex = {0}
	specialCoords = {{stage = 1, x = 17*gridsize, y = 20*gridsize, char = player, triggered = 0}}

-- actions
	actionMode = 0
	usedItem = 0
	actions = {player = {current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
							npcs = {
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0},
								{current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0}
							}
						}
--battle
	battleMode = 0
	battleGlobal = {maxmoves = #player.party + 2, movesTaken = 0, turn = 0, phase = 0}

	require("scripts/battle")
	--object text index for background objects
	staticObjects = {overworld = {
		{name = "gardeningSign", x = 16*gridsize, y = 17*gridsize},
		{name = "kitchenSign",  x = 23*gridsize, y = 17*gridsize},
	 	{name = "dormitorySign",  x = 29*gridsize, y = 26*gridsize},
		{name = "storeSign",  x = 29*gridsize, y = 34*gridsize}
		-- {"barrelSmBerriesStatic", 15*gridsize, 34*gridsize, off = 0},
		-- {"barrelLgBerriesStatic", 19*gridsize, 34*gridsize, off = 0}
		},
		dormitory = {
			{name = "playerBed", x = 15*gridsize, y = 16*gridsize}
		}
	}

	objectInventory = {barrelSmBerries = 0, barrelLgBerries = 0}

	itemStats = {plantSmBerries = {max = 60, stackable = 1, dropNum = 10},
							plantLgBerries = {max = 60, stackable = 1, dropNum = 10},
							platefull2 = {max = 60, stackable = 0, dropNum = 1}
							}
	itemText = ""
	animsheet2 = love.graphics.newImage("images/solidarity_object_anim.png")
	movingObjectData = {overworld =
												{plantSmBerries = {
														{x = 11*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 12*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 13*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 14*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 15*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 18*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 19*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 20*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 21*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 22*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 11*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 12*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 13*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 15*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 18*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 19*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 20*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 21*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0}
													},
												plantSm = {
														{x = 14*gridsize, y = 25*gridsize, visible = 1, anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantSm}}, loop = 1, current = 0, running = 0, count = 0},
														{x = 22*gridsize, y = 25*gridsize, visible = 1 ,anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantSm}}, loop = 1, current = 0, running = 0, count = 0}
													},
												plantLgBerries = {
														{x = 11*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 12*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 13*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 14*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 18*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 19*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 20*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 21*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 22*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 11*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 13*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 14*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 15*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 18*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 19*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 20*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 21*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0},
														{x = 22*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0}
													},
												plantLg = {
														{x = 15*gridsize, y = 28*gridsize, visible = 1, anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantLg}}, loop = 1, current = 0, running = 0, count = 0},
														{x = 12*gridsize, y = 29*gridsize, visible = 1, anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantLg}}, loop = 1, current = 0, running = 0, count = 0}
												},
												barrelSmBerries = {
														{x = 15*gridsize, y = 22*gridsize, visible = 1, anim = newAnimation(animsheet2, 2*16, 4, 16, 16, .3), loop = 2, current = 0, running = 0, count = 0}
													},
												barrelLgBerries = {
														{x = 18*gridsize, y = 22*gridsize, visible = 1, anim = newAnimation(animsheet2, 3*16, 4, 16, 16, .3), loop = 2, current = 0, running = 0, count = 0}
													},
												}
											}

	nonInteractiveObjects = {overworld = {fenceopenL = {
																					{x = 16*gridsize, y = 21*gridsize, visible = 1}
																				},
																				fenceopenR = {
																					{x = 17*gridsize, y = 21*gridsize, visible = 1}
																				},
																				fenceclosedL = {
																					{x = 16*gridsize, y = 21*gridsize, visible = 0}
																				},
																				fenceclosedR = {
																					{x = 17*gridsize, y = 21*gridsize, visible = 0}
																				},
																			},
													dininghall = {stool = {
																					{name = "stool", x = 12*gridsize, y = 12*gridsize, visible = 1},
																					{name = "stool", x = 14*gridsize, y = 12*gridsize, visible = 1},
																					{name = "stool", x = 17*gridsize, y = 12*gridsize, visible = 1},
																					{name = "stool", x = 18*gridsize, y = 12*gridsize, visible = 1},
																					{name = "stool", x = 19*gridsize, y = 12*gridsize, visible = 1},
																					{name = "stool", x = 23*gridsize, y = 12*gridsize, visible = 1},
																					{name = "stool", x = 24*gridsize, y = 12*gridsize, visible = 1},
																					{name = "stool", x = 12*gridsize, y = 16*gridsize, visible = 1},
																					{name = "stool", x = 13*gridsize, y = 16*gridsize, visible = 1},
																					{name = "stool", x = 14*gridsize, y = 16*gridsize, visible = 1},
																					{name = "stool", x = 18*gridsize, y = 16*gridsize, visible = 1},
																					{name = "stool", x = 19*gridsize, y = 16*gridsize, visible = 1},
																					{name = "stool", x = 22*gridsize, y = 16*gridsize, visible = 1},
																					{name = "stool", x = 23*gridsize, y = 16*gridsize, visible = 1}
																			}
																		}
													}


	-- tiles that are rendered on top of the player and npcs
	toptilesSheet = love.graphics.newImage("images/solidarity_toptiles.png")
	toptiles = {doorway = love.graphics.newQuad(0, 0, 16, 16, toptilesSheet:getDimensions()),
							black = love.graphics.newQuad(1*gridsize, 0, 16, 16, toptilesSheet:getDimensions())
							}
	toptileData = {gardeningShed = {{name = "doorway", x = locationTriggers.gardeningShed[1].x, y = locationTriggers.gardeningShed[1].y, visible = 1}
																 },
								dormitory = {{name = "doorway", x= locationTriggers.dormitory[1].x, y = locationTriggers.dormitory[1].y, visible = 1},
														 {name = "doorway", x= locationTriggers.dormitory[2].x, y = locationTriggers.dormitory[2].y, visible = 1}
													 	},
							  dininghall = {{name = "doorway", x= locationTriggers.dininghall[1].x, y = locationTriggers.dininghall[1].y, visible = 1},
														  {name = "doorway", x= locationTriggers.dininghall[2].x, y = locationTriggers.dininghall[2].y, visible = 1}
														},
								store = {{name = "doorway", x= locationTriggers.store[1].x, y = locationTriggers.store[1].y, visible = 1}
																							 }
								}

--- animated objects
	-- objectAnimations = {{anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0},
	-- 			 							{anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), name = "plantLgBerries", loop = 1, current = 0, running = 0, count = 0},
	-- 									  {anim = newAnimation(animsheet2, 2*16, 4, 16, 16, .3), name = "barrelSmBerries", loop = 2, current = 0, running = 0, count = 0},
	-- 										{anim = newAnimation(animsheet2, 3*16, 4, 16, 16, .3), name = "barrelLgBerries", loop = 2, current = 0, running = 0, count = 0}
	-- 									}

	animsheet_act = love.graphics.newImage("images/solidarity_anim_act.png")
--spritesheet, number of tiles in animation, starting position, length, width, height, duration-- loop = 0 is infinite loop

	--fading
	fading = {on = false, type = 1, start = 0, goal = 0, rate = 0, a = 0, countdown = 0, triggered = 0} -- type 1 = fade in from 0 to 255; 2 = fade out from 255 to 0
	--cutscene
	cutsceneControl = {stage = 0, total = 2, current = 1}
	-- types: 1 = talk, 2 = changeScene
	cutsceneList ={{
		setup = 0,
		triggered = false,
		type = 1,
		move = true, --does the NPC move?
		npc = 4, --which NPC
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
		switchTime = 2 -- what time of day is it after the end
	},
	{
		triggered = false,
		type = 1,
		move = true, --does the NPC move?
		npc = 6, --which NPC
		target = player, -- where do they move
		facing = {1}, --what direction are they facing at the end
		noden = 1, --what node are they walking to next
		dialoguekey = 1,
		path = {},
		fadeout = 0,
		black = 0,
		goback = true, -- npc goes back to starting position
		skipnext = false, -- do we go directly to next cutscene?
		nextStage = true, -- do we go to the next game scene
		switchTime = 2 -- what time of day is it after the end
	}}


--dialogue
	font = love.graphics.setNewFont("fonts/pixel.ttf", 8)
	dialogueMode = 0
	dialogueStage = 0
	choice = {mode = 0, pos = 1, total = 1, name = "", case = 0, more = 0}
	text = nil
	textsub = ""
	textn = 0
	trigger = {0}
	wait = {start = .8, rate = 1, current = 0, triggered = 0, n = 0}

	--timer for blinking text/images
		timer = {{base = .5, current = 0, trigger = 0}, -- blinking arrow
						 {base = .03, current = 0, trigger = 0}} --unrolling text

	--dialogue and object descriptions
	require("scripts/dialoguefunctions")

	-- other scripts
	require("scripts/movefunctions")
	require("scripts/pathfinding")
	require("scripts/cutscenefunctions")
	require("scripts/actionfunctions")
	require("scripts/dialogue")
	require("scripts/menufunctions")


--editor for creating new maps and other functions
	require("scripts/mapfunctions")

	--generate map
	mapFile1 = mapPath.overworld[1]
	mapGen (bg.overworld, mapFile1)
	--table.save(initTable, "D:\\my game projects\\utopia\\scripts\\initTable.lua")

	-- add location of NPCs or other moving obstacles to map collision
	updateMap(npcs)
	npcActSetup()


	menuW, menuH = 14*gridsize, 7*gridsize
	canvas = love.graphics.newCanvas(menuW, menuH)
	formBox(menuW, menuH)
	lockDialogue(locationTriggers[currentLocation])
end


function love.update(dt)
	cutsceneTrigger()

	--run timers for blinking text
	if dialogueMode == 1 then
		timerBlink(dt, 1)

	-- run timer for scrolling text
		timerText(dt, 2)
	end

	if menuView == 1 then
		timerBlink(dt, 1)
	end
	--immobilize player if dialoguemode active
	if dialogueMode == 1 then
		player.canMove = 0
	end

	-- initiate dialogue and move character back if they enter a location
	if gameStage == 1 then
		local i = getCharIndex("Finch")
		if objectInventory.barrelSmBerries + objectInventory.barrelLgBerries >= 60 then
			if areaCheck(16, 21, 17, 22, player) then
				local bool1, k = checkInventory("Plum Berries")
				local bool2, k = checkInventory("Rose Berries")
				if bool1 == 0 and bool2 == 0 then
					if npcs[i].c ~= 3 then
						removeTempBlocks(currentLocation, 1)
						npcs[i].c = 3
					end
				else
					if npcs[i].c ~= 4 then
						npcs[i].c = 4
						print("npcs[i].c " ..  npcs[i].c)
					end
				end
			end
		end
	elseif gameStage == 2 then
		local i = getCharIndex("Finch")
		if tempBlocks.overworld[2].on == 0 then
			tempBlocks.overworld[2].on = 1
			tempBlocks.overworld[3].on = 1
			nonInteractiveObjects.overworld.fenceopenL[1].visible = 0
			nonInteractiveObjects.overworld.fenceopenR[2].visible = 0
			nonInteractiveObjects.overworld.fenceclosedL[3].visible = 1
			nonInteractiveObjects.overworld.fenceclosedR[4].visible = 1
			addTempBlocks(initTable)
			saveMap()
		end
	end
	if dialogueMode == 0 then
		if trigger[1] == 0 then
			DialogueTrigger(17, 21, 3)
		end
	end
	if dialogueMode == 0 then
		if player.canMove == 1 and currentLocation == "overworld" then
			if gameStage == 0 then
				moveCharBack(17, 21, 17, 22, 2)
			elseif gameStage == 1 then
				if objectInventory.barrelSmBerries + objectInventory.barrelLgBerries < 60 then
					moveCharBack(17, 21, 17, 22, 2)
				else
					local i = getCharIndex("Finch")
					if npcs[i].c == 4 then
						moveCharBack(17, 21, 17, 22, 2)
					end
				end
			end
		end
	end


	--run through countdown
	fadeCountdown(dt)
	-- turn of key inputs
	if wait.triggered == 1 then
		inputWait(wait.n, dt)
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
	if dialogueMode == 0 and menuView == 0 then
		if cutsceneControl.stage < 1 then
			if time == 1 and currentLocation == "overworld" then
				for i = 1, #npcs do
					if npcs[i].location == "overworld" and npcs[i].randomturn == 1 then
						npcs[i].timer.ct = randomFacing(npcs[i], npcs[i].timer.mt, npcs[i].timer.ct, dt)
					end
				end
			end
		end
	end

	npcActUpdate(dt)
	--animation time update
	animUpdate(player.animations.walk, dt, player.facing)

	if actions.player.key ~= 0 and actions.player.index ~= 0 then
		if movingObjectData[currentLocation][actions.player.key][actions.player.index].running == 1 then
			animUpdate(movingObjectData[currentLocation][actions.player.key], dt, actions.player.index)
		end
	end
	if actionMode == 1 then
		if player.animations.act[player.facing].running == 1 then
			animUpdate(player.animations.act, dt, player.facing)
		end
	end
	for i = 1, #npcs do
		if npcs[i].working == 1 then
			animUpdate(npcs[i].animations.act, dt, npcs[i].start)
			testNpcObject(npcs[i].start, npcs[i].grid_x, npcs[i].grid_y, movingObjectData[currentLocation], i, dt)
			-- if movingObjectData[currentLocation][actions.npcs[i].key][actions.npcs[i].index].running == 1 then
			-- 	animUpdate(movingObjectData[currentLocation][actions.npcs[i].key], dt, actions.npcs[i].index)
			-- end
			if movingObjectData[currentLocation][actions.npcs[i].key][actions.npcs[i].index].running == 1 then
				animUpdate(movingObjectData[currentLocation][actions.npcs[i].key], dt, actions.npcs[i].index)
			end
		else
			animUpdate(npcs[i].animations.walk, dt, npcs[i].facing)
		end
	end

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
	for k, v in pairs(movingObjectData[currentLocation]) do
		for i = 1, #movingObjectData[currentLocation][k] do
			drawActAnims(movingObjectData[currentLocation][k], i, movingObjectData[currentLocation][k][i].x, movingObjectData[currentLocation][k][i].y)
		end
	end


	--draw extra infoView
	if infoView == 1 then
		drawInfo(player.act_x, player.act_y)
	end

	--render player
	drawPlayer(player.animations.walk)


	--render npcs
	for i = 1, #npcs do
		drawNPCs(npcs[i].animations.walk, i)
	end
	-- render tiles on top of player
	if currentLocation ~= "overworld" then
		drawStillObjects(currentLocation, toptileData, toptilesSheet, toptiles)
	end

	-- add multiply screen for evening
 	-- multiplyLayer(width, height)
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
		love.graphics.draw(ui.textboxbg, boxposx, boxposy)

		--draw name of character speaking and text box
		drawName(boxposx, boxposy)

		if dialogueMode == 1 then
			drawPortrait(currentspeaker, boxposx-2, boxposy, portraitsheet1)
		end
		love.graphics.draw(ui.textboxbottom, boxposx, boxposy)
		--draw z or arrow if more text
		drawArrow(boxposx, boxposy, scale.y, recwidth)
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

	love.graphics.pop()
end

-- KEY PRESSES --
---------------
function love.keypressed(key)
	print("key pressed, keyInput = " .. keyInput)
	if keyInput == 1 then
	--initiate debug/map editing mode
	  if key == "p" then
		 	if debugView == 0 then
	    	debugView = 1
			elseif debugView == 1 then
				debugView = 0
			end
			if infoView == 0 then
				infoView = 1
			else
				infoView = 0
			end
	  end
	--print additional info about game on screen for debugging
		if key == "i" then
			if dialogueMode == 0 then
				if menuView == 0 then
					player.canMove = 0
					menuView = 1
				else
					player.canMove = 1
					menuView = 0
				end
			end
		end
	--- interact with objects or people
	  if key == "z" then
			print("pressed z")
			textn = 0
			if menuView == 0 then
				if usedItem == 1 then
					afterItemUse()
				end
				DialogueSetup(npcs, dialogueStage)
				faceObject(player, player.facing, staticObjects[currentLocation]) -- still objects
				faceObject(player, player.facing, movingObjectData[currentLocation])
				faceObject(player, player.facing, locationTriggers[currentLocation])
				if actions.player.key ~= 0 then
					resetAnims(movingObjectData[currentLocation][actions.player.key], actions.player.index)
				end
				if actionMode == 1 then
					resetAnims(player.animations.act, player.facing)
				end
			else
				 menuHierarchy(key)
			end
			print("dialogueMode after z" .. dialogueMode)
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
				cutsceneControl.stage = 8
				player.canMove = 1
			end
		end

		if key == "1" then
			player.energy = 100
		end

		if key == "0" then
			player.energy = 0
		end

		if key == "6" then
			addRemoveItem("You got 60 Plum Berries", "Plum Berries", 60, "plantSmBerries")
		end

		if key == "l" then
			changeGameStage()
			cutsceneControl.current = cutsceneControl.current + 1
			cutsceneControl.stage = 0
			print("gameStage: " .. gameStage)
		end

	-- move between dialogue or menu options

	if key == "down" or key == "up" then
		if menuView ~= 1 then
			if choice.mode == 1 then
				choiceChange(key)
			end
		else
			if menu.position[1] == 3 then
				if menu.currentTab == "inventory" then
					inventorySelect(key)
				end
			end
		end
	end
	if key == "left" or key == "right" then
		if menuView == 1 then
			if menu.position[1] == 1 then
				menu.currentTab = switchTabs(key)
			elseif menu.position[1] == 2 then
				if menu.currentTab == "inventory" then
					inventorySelect(key)
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
			end
		else
			menuHierarchy(key)
		end
	end

	if key == "f11" then
		local fullscreen, fstype = love.window.getFullscreen( )
		if fullscreen == false then
			love.window.setFullscreen(true, "exclusive")
			scale.x, scale.y = getScale()
		else
			love.window.setFullscreen(false, "exclusive")
			scale.x, scale.y = getScale()
		end
	end
	if key == "escape" then
		if menuView == 0 then
			removeTempBlocks("overworld", 2)
			saveMap()
	 		love.event.quit()
		else
			menuView = 0
			menu.position[2] = 1
			player.canMove = 1
		end
	end
end
