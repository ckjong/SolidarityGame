


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
	locationTriggers = {
										overworld = {
											{x = 17*gridsize, y = 16*gridsize, name = "gardeningShed", x2 = 11*gridsize, y2 = 17*gridsize, locked = 1},--entrancex, entrancey, name, newplayerx, newplayery, locked (1 = yes)
											{x = 30*gridsize, y = 25*gridsize, name = "dormitory", x2 = 12*gridsize, y2 = 17*gridsize, locked = 0},
											{x = 34*gridsize, y = 25*gridsize, name = "dormitory", x2 = 25*gridsize, y2 = 17*gridsize, locked = 0},
											{x = 24*gridsize, y = 16*gridsize, name = "dininghall", x2 = 13*gridsize, y2 = 20*gridsize, locked = 1},
											{x = 28*gridsize, y = 16*gridsize, name = "dininghall", x2 = 23*gridsize, y2 = 20*gridsize, locked = 1},
											{x = 30*gridsize, y = 33*gridsize, name = "store", x2 = 17*gridsize, y2 = 19*gridsize, locked = 0}},
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
	currentLocation = "overworld"
	mapPath = {overworld = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\1overworld.txt"},
	gardeningShed = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\2gardeningShed.txt"},
	battlefield1 = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\3battlefield1.txt"},
	dormitory = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\4dormitory.txt"},
	dininghall = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\5dininghall.txt"},
	store = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\6store.txt"}

}

	mapFile1 = nil


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
		maxInventory = 60,
		party = {1, 2}, -- Fennel, Mint
		spells = {},
		energy = 100,
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
			location = "overworld",
			dialogue = 0,
			name = "Mint",
			status = "worker",
			animationkey = 9,
			n = 1,
			c = 1,
			battlestats = {maxhp = 2, damage = 1, moves = 2},
			next = {{x = 21*gridsize, y = 23*gridsize, facing = 2, location = "overworld"}}
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
				next = {{x = 10*gridsize, y = 28*gridsize, facing = 4, location = "overworld"}}
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
				grid_y = 26*gridsize,
				act_x = 21*gridsize,
				act_y = 26*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 1,
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
				location = "overworld",
				dialogue = 0,
				name = "Agave",
				status = "worker",
				animationkey = 25, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 17*gridsize, y = 16*gridsize, facing = 2, location = "dininghall"}}
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
				location = "overworld",
				dialogue = 0,
				name = "Tarragon",
				status = "worker",
				animationkey = 29, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {maxhp = 3, damage = 1,  moves = 1},
				next = {{x = 26*gridsize, y = 16*gridsize, facing = 2, location = "dormitory"}}
			}
}

	storedLocation = {x = 0, y = 0}
	storedIndex = 0

-- actions
	actionMode = 0
	actions = {{current = 0, max = 100, rate = 10, x = 0, y = 0, k = 0}
						}
--battle
	battleMode = 0
	battleGlobal = {maxmoves = #player.party + 2, movesTaken = 0, turn = 0, phase = 0}

	require("scripts/battle")
	--object text index for background objects
	staticObjects = {overworld = {
		{name = "GardeningSign", x = 16*gridsize, y = 17*gridsize},
		{name = "KitchenSign",  x = 23*gridsize, y = 17*gridsize},
	 	{name = "DormitorySign",  x = 29*gridsize, y = 26*gridsize},
		{name = "StoreSign",  x = 29*gridsize, y = 34*gridsize}
		-- {"barrelSmBerriesStatic", 15*gridsize, 34*gridsize, off = 0},
		-- {"barrelLgBerriesStatic", 19*gridsize, 34*gridsize, off = 0}
		}
	}

	objectInventory = {barrelSmBerries = 0, barrelLgBerries = 0}
--images
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setColor(0, 0, 0)
	love.graphics.setBackgroundColor(255,255,255)

	bg = {overworld = love.graphics.newImage("images/solidarity_overworld.png"),
				overworldnight = love.graphics.newImage("images/solidarity_overworld_night.png"),
				gardeningShed = love.graphics.newImage("images/gardeningshedbg.png"),
				battlefield1 = love.graphics.newImage("images/solidarity_battletest.png"),
		  	dormitory = love.graphics.newImage("images/dormitory.png"),
				dininghall = love.graphics.newImage("images/dininghall.png"),
				store = love.graphics.newImage("images/store.png"),
			}
	currentBackground = bg.overworld
	daytime = 1 -- 1 = day, 2 = evening, 3 = night

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

	animsheet1 = love.graphics.newImage("images/solidarity_anim.png")
	ui = {arrowup = love.graphics.newImage("images/solidarity_ui_0.png"),
		arrowdown = love.graphics.newImage("images/solidarity_ui_1.png"),
		arrowright = love.graphics.newImage("images/solidarity_ui_2.png"),
		arrowleft = love.graphics.newImage("images/solidarity_ui_3.png"),
		pressz = love.graphics.newImage("images/solidarity_ui_4.png"),
		textboxbg = love.graphics.newImage("images/solidarity_textboxfull.png"),
		textboxbottom = love.graphics.newImage("images/solidarity_textboxbottom.png"),
		energyicon = love.graphics.newImage("images/solidarityui_16x16_0.png"),
		energytextbg = love.graphics.newImage("images/solidarityui_16x16_1.png"),
		energytextbground = love.graphics.newImage("images/solidarityui_16x16_2.png"),
		energyboltlg = love.graphics.newImage("images/solidarityui_16x16_3.png"),
		energyboltsm = love.graphics.newImage("images/solidarityui_16x16_4.png"),
		energytextbgcircle = love.graphics.newImage("images/solidarityui_16x16_5.png"),
		energytextbgsmleft = love.graphics.newImage("images/solidarityui_16x16_6.png"),
		energytextbgsmright = love.graphics.newImage("images/solidarityui_16x16_7.png")
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

	menu = {currentTab = "inventory", allTabs = {"inventory", "journal", "map1", "map2"}}

	-- objects that are not part of static background
	movingObjectSheet = love.graphics.newImage("images/solidarity_objects.png")
	movingObjectQuads = {stool = love.graphics.newQuad(0, 0, 16, 16, movingObjectSheet:getDimensions()),
											 platefull = love.graphics.newQuad(1*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantSm = love.graphics.newQuad(2*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantSmBerries = love.graphics.newQuad(3*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantLg = love.graphics.newQuad(4*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 plantLgBerries = love.graphics.newQuad(5*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 barrelSmBerries = love.graphics.newQuad(6*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											 barrelLgBerries = love.graphics.newQuad(7*gridsize, 0, 16, 16, movingObjectSheet:getDimensions()),
											}
	movingObjectData = {overworld = {{name = "plantSmBerries", x = 11*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 12*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 13*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 14*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 15*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 18*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 19*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 20*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 21*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 22*gridsize, y = 24*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 11*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 12*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 13*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSm", x = 14*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 15*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 18*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 19*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 20*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSmBerries", x = 21*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantSm", x = 22*gridsize, y = 25*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 11*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 12*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 13*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 14*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLg", x = 15*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 18*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 19*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 20*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 21*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 22*gridsize, y = 28*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 11*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLg", x = 12*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 13*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 14*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 15*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 18*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 19*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 20*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 21*gridsize, y = 29*gridsize, visible = 1},
																		{name = "plantLgBerries", x = 22*gridsize, y = 29*gridsize, visible = 1},
																		{name = "barrelSmBerries", x = 15*gridsize, y = 22*gridsize, visible = 1},
																		{name = "barrelLgBerries", x = 18*gridsize, y = 22*gridsize, visible = 1}
																	 },
											dininghall = {{name = "stool", x = 12*gridsize, y = 12*gridsize, visible = 1},
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
	animsheet2 = love.graphics.newImage("images/solidarity_object_anim.png")
	objectAnimations = {{anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), "plantSmBerries", loop = 1, current = 0, running = 0},
				 							{anim = newAnimation(animsheet2, 1*16, 3, 16, 16, .3), "plantLgBerries", loop = 1, current = 0, running = 0},
										  {anim = newAnimation(animsheet2, 2*16, 4, 16, 16, .3), "barrelSmBerries", loop = 1, current = 0, running = 0},
											{anim = newAnimation(animsheet2, 3*16, 4, 16, 16, .3), "barrelLgBerries", loop = 1, current = 0, running = 0}
										}

	animsheet_act = love.graphics.newImage("images/solidarity_anim_act.png")
--spritesheet, number of tiles in animation, starting position, length, width, height, duration-- loop = 0 is infinite loop
	animations = {{anim = newAnimation(animsheet1, 0, 4, 16, 16, .6), name = "player.walkup", loop = 0},
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
				{anim = newAnimation(animsheet1, 27*16, 4, 16, 16, .65 ), name = "npcs[6].walkright", loop = 0},
				{anim = newAnimation(animsheet1, 28*16, 4, 16, 16, .6 ), name = "npcs[7].walkup", loop = 0},
				{anim = newAnimation(animsheet1, 29*16, 4, 16, 16, .6 ), name = "npcs[7].walkdown", loop = 0},
				{anim = newAnimation(animsheet1, 30*16, 4, 16, 16, .65 ), name = "npcs[7].walkleft", loop = 0},
				{anim = newAnimation(animsheet1, 31*16, 4, 16, 16, .65 ), name = "npcs[7].walkright", loop = 0},
			 }


	anim_act = {{anim = newAnimation(animsheet_act, 0, 4, 16, 16, .6), name = "player.actup", loop = 1, current = 0, running = 0},
				{anim = newAnimation(animsheet_act, 1*16, 4, 16, 16, .6), name = "player.actdown", loop = 1, current = 0, running = 0},
				{anim = newAnimation(animsheet_act, 2*16, 4, 16, 16, .6), name = "player.actleft", loop = 1, current = 0, running = 0},
				{anim = newAnimation(animsheet_act, 3*16, 4, 16, 16, .6), name = "player.actright", loop = 1, current = 0, running = 0}}
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
	textsub = ""
	textn = 0
	trigger = {0}
	wait = {start = .8, rate = 1, current = 0, triggered = 0}

	--dialogue and object descriptions
	require("scripts/dialoguefunctions")
	require("scripts/movefunctions")
	require("scripts/pathfinding")
	require("scripts/cutscenefunctions")
	require("scripts/actionfunctions")
	require("scripts/dialogue")

--timer for blinking text/images
	timer = {{base = .5, current = 0, trigger = 0}, -- blinking arrow
					 {base = .03, current = 0, trigger = 0}} --unrolling text
--editor for creating new maps and other functions
	require("scripts/mapfunctions")

	--generate map
	mapFile1 = mapPath.overworld[1]
	mapGen (bg.overworld, mapFile1)
	--table.save(initTable, "D:\\my game projects\\utopia\\scripts\\initTable.lua")

	-- add location of NPCs or other moving obstacles to map collision
	updateMap(npcs)
	menuW, menuH = 14*gridsize, 7*gridsize
	canvas = love.graphics.newCanvas(menuW, menuH)
	formBox(menuW, menuH)
	lockDialogue(locationTriggers[currentLocation])
end


function love.update(dt)
	if gameStage == 0 then
		if checkSpoken(npcs, NPCdialogue[dialogueStage], 6) == true then
			if cutsceneControl.stage == 0 then
				local n = cutsceneControl.current
				if cutsceneList[n].triggered == false then
					print("spoken to everyone")
					cutsceneControl.stage = 1
				end
			end
		end
	end

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
	if dialogueMode == 0 then
		if trigger[1] == 0 then
			DialogueTrigger(17, 21, 3)
		end
		if player.canMove == 1 and currentLocation == "overworld" then
			if gameStage == 0 then
				moveCharBack(17, 21, 17, 22, 2)
			elseif gameStage == 1 then
				if objectInventory.barrelSmBerries + objectInventory.barrelLgBerries < 60 then
					moveCharBack(17, 21, 17, 22, 2)
				else
					if areaCheck(16, 21, 17, 22, player) then
						local bool1, k = checkInventory("Plum Berries")
						local bool2, k = checkInventory("Rose Berries")
						print("bool1 and 2 " .. bool1 .. bool2)
						if bool1 == 0 and bool2 == 0 then
							npcs[4].c = 3
						else
							npcs[4].c = 4
							moveCharBack(17, 21, 17, 22, 2)
						end
					end
				end
			end
		end
	end

	--run through countdown
	fadeCountdown(dt)
	-- turn of key inputs
	if wait.triggered == 1 then
		inputWait(dt)
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
	animUpdate(animations, dt)
	if actionMode == 1 then
		if actions[1].k ~= 0 then
			if objectAnimations[actions[1].k].running == 1 then
				animUpdate(objectAnimations, dt)
			end
		end
		if anim_act[player.facing].running == 1 then
			animUpdate(anim_act, dt)
		end
	end

	if player.energy <= 0 then
		if freeze.action ~= 2 then
			freeze.action = 1
		end
		freeze.dialogue = 1
	else
		if freeze.action == 1 then
			freeze.action = 0
		end
		if freeze.dialogue == 1 then
			freeze.dialogue = 0
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
	scale.x, scale.y = getScale()
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
	drawStillObjects(currentLocation, movingObjectData, movingObjectSheet, movingObjectQuads)
	if actions[1].k ~= 0 then
		drawActAnims(objectAnimations, actions[1].k, actions[1].x, actions[1].y)
	end
	if actionMode == 1 then
		drawActAnims(anim_act, player.facing, player.act_x, player.act_y)
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
		drawStillObjects(currentLocation, toptileData, toptilesSheet, toptiles)
	end

	-- add multiply screen for evening
 	-- multiplyLayer(width, height)
	if menuView == 1 then
		drawMenu(player.act_x, player.act_y, menu.currentTab)
	end
	--render dialogue box and text
	if text ~= nil and dialogueMode == 1 then
		love.graphics.setColor(255, 255, 255)
		local recheight = 32
		local recwidth = 232
		local xnudge = width/2
		local ynudge = 1*scale.y
		local boxposx = player.act_x + gridsize/2 - recwidth/2
		local boxposy = player.act_y + gridsize/2 + (height/scale.y)/2 - recheight - ynudge
		 -- - recheight + ynudge
		--render dialogue box
		love.graphics.draw(ui.textboxbg, boxposx, boxposy)
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

	drawMeters(player.act_x-106, player.act_y-76)

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
			textn = 0
			if freeze.dialogue == 0 then
				if menuView == 0 then
					DialogueSetup(npcs, dialogueStage)
				end
			elseif freeze.dialogue == 1 then
				if dialogueMode == 1 then
					DialogueSetup(npcs, dialogueStage)
				end
			end
			if menuView == 0 then
				faceObject(player.facing, staticObjects[currentLocation]) -- still objects
				faceObject(player.facing, movingObjectData[currentLocation])
				faceObject(player.facing, locationTriggers[currentLocation])
				if actionMode == 1 then
					if actions[1].k ~= 0 then
						resetAnims(objectAnimations, actions[1].k)
					end
					resetAnims(anim_act, player.facing)
				end
			end
		end

		if key == "x" then
			exitAction()
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
			print("gameStage: " .. gameStage)
		end

	-- move between dialogue or menu options

	if key == "up" then
		if choice.mode == 1 then
			if choice.pos > 1 then
				choice.pos = choice.pos - 1
				choiceText(NPCdialogue[dialogueStage][choice.name][choice.case].text, choice.pos, choice.total)
			end
		end
	end
	if key == "down" then
		if choice.mode == 1 then
			if choice.pos >= 1 and choice.pos < choice.total then
				choice.pos = choice.pos + 1
				choiceText(NPCdialogue[dialogueStage][choice.name][choice.case].text, choice.pos, choice.total)
			end
		end
	end
	if key == "left" then
		if menuView == 1 then
			menu.currentTab = switchTabs(key)
		end
	end
	if key == "right" then
		if menuView == 1 then
			menu.currentTab = switchTabs(key)
		end
	end


	-- end battle
		if battleMode == 1 and key == "q" then
			battleMode = 0
			battleGlobal.phase = 0
			-- battleEnd(storedLocation.x, storedLocation.y)
		end
	end
	if key == "f11" then
		local fullscreen, fstype = love.window.getFullscreen( )
		if fullscreen == false then
			love.window.setFullscreen(true, "exclusive")
		else
			love.window.setFullscreen(false, "exclusive")
		end
	end
	if key == "escape" then
		if menuView == 0 then
	 		love.event.quit()
		else
			menuView = 0
			player.canMove = 1
		end
	end
end
