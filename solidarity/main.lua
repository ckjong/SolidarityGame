


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
											{17*gridsize, 16*gridsize, "gardeningShed", 11*gridsize, 17*gridsize, 0},--entrancex, entrancey, name, newplayerx, newplayery, locked (1 = yes)
											{30*gridsize, 25*gridsize, "dormitory", 12*gridsize, 17*gridsize, 0},
											{34*gridsize, 25*gridsize, "dormitory", 25*gridsize, 17*gridsize, 0},
											{24*gridsize, 16*gridsize, "dininghall", 13*gridsize, 20*gridsize, 0},
											{28*gridsize, 16*gridsize, "dininghall", 23*gridsize, 20*gridsize, 0},
											{30*gridsize, 33*gridsize, "store", 17*gridsize, 19*gridsize, 0}},
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
										store = {
												{17*gridsize, 20*gridsize, "overworld", 30*gridsize, 34*gridsize, 0}}
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
		grid_y = 31*gridsize,
		act_x = 18*gridsize,
		act_y = 31*gridsize,
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
			grid_y = 26*gridsize,
			act_x = 14*gridsize,
			act_y = 26*gridsize,
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
			next = {{x = 20*gridsize, y = 25*gridsize, facing = 1, location = "overworld"}}
			},
			{
				grid_x = 10*gridsize,
				grid_y = 28*gridsize,
				act_x = 10*gridsize,
				act_y = 28*gridsize,
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
				grid_x = 13*gridsize,
				grid_y = 32*gridsize,
				act_x = 13*gridsize,
				act_y = 32*gridsize,
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
				grid_x = 14*gridsize,
				grid_y = 34*gridsize,
				act_x = 14*gridsize,
				act_y = 34*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 1,
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
		{"GardeningSign", 16*gridsize, 17*gridsize},
		{"KitchenSign", 23*gridsize, 17*gridsize},
	 	{"DormitorySign", 29*gridsize, 26*gridsize},
		{"StoreSign", 29*gridsize, 34*gridsize}
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
	ui = {arrowright = love.graphics.newImage("images/utopiaui_0.png"),
		arrowdown = love.graphics.newImage("images/utopiaui_5.png"),
		pressz = love.graphics.newImage("images/utopiaui_6.png"),
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
	movingObjectData = {overworld = {{"plantSmBerries", 11*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 12*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 13*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 14*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 15*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 18*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 19*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 20*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 21*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 22*gridsize, 24*gridsize, 1},
																		{"plantSmBerries", 11*gridsize, 27*gridsize, 1},
																		{"plantSmBerries", 12*gridsize, 27*gridsize, 1},
																		{"plantSmBerries", 13*gridsize, 27*gridsize, 1},
																		{"plantSm", 14*gridsize, 27*gridsize, 1},
																		{"plantSmBerries", 15*gridsize, 27*gridsize, 1},
																		{"plantSmBerries", 18*gridsize, 27*gridsize, 1},
																		{"plantSmBerries", 19*gridsize, 27*gridsize, 1},
																		{"plantSmBerries", 20*gridsize, 27*gridsize, 1},
																		{"plantSmBerries", 21*gridsize, 27*gridsize, 1},
																		{"plantSm", 22*gridsize, 27*gridsize, 1},
																		{"plantLgBerries", 11*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 12*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 13*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 14*gridsize, 30*gridsize, 1},
																		{"plantLg", 15*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 18*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 19*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 20*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 21*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 22*gridsize, 30*gridsize, 1},
																		{"plantLgBerries", 11*gridsize, 33*gridsize, 1},
																		{"plantLg", 12*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 13*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 14*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 15*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 18*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 19*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 20*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 21*gridsize, 33*gridsize, 1},
																		{"plantLgBerries", 22*gridsize, 33*gridsize, 1},
																		{"barrelSmBerries", 15*gridsize, 22*gridsize, 1},
																		{"barrelLgBerries", 18*gridsize, 22*gridsize, 1}
																	 },
											dininghall = {{"stool", 12*gridsize, 12*gridsize, 1},
																		{"stool", 14*gridsize, 12*gridsize, 1},
																		{"stool", 17*gridsize, 12*gridsize, 1},
																		{"stool", 18*gridsize, 12*gridsize, 1},
																		{"stool", 19*gridsize, 12*gridsize, 1},
																		{"stool", 23*gridsize, 12*gridsize, 1},
																		{"stool", 24*gridsize, 12*gridsize, 1},
																		{"stool", 12*gridsize, 16*gridsize, 1},
											 							{"stool", 13*gridsize, 16*gridsize, 1},
																		{"stool", 14*gridsize, 16*gridsize, 1},
																		{"stool", 18*gridsize, 16*gridsize, 1},
																		{"stool", 19*gridsize, 16*gridsize, 1},
																		{"stool", 22*gridsize, 16*gridsize, 1},
																		{"stool", 23*gridsize, 16*gridsize, 1}
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
	canvas = love.graphics.newCanvas(80, 80)
	formBox(80, 80)
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
	drawTop(currentLocation, movingObjectData, movingObjectSheet, movingObjectQuads)
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
		drawTop(currentLocation, toptileData, toptilesSheet, toptiles)
	end

	-- add multiply screen for evening
 	-- multiplyLayer(width, height)
	if menuView == 1 then
		drawMenu(player.act_x, player.act_y)
	end
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
			drawPortrait(currentspeaker, boxposx-2, boxposy, portraitsheet1)
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
			if menuView == 0 then
				menuView = 1
			else
				menuView = 0
			end
		end
	--- interact with objects or people
	  if key == "z" then
			textn = 0
			if freeze.dialogue == 0 then
				DialogueSetup(npcs, dialogueStage)
			elseif freeze.dialogue == 1 then
				if dialogueMode == 1 then
					DialogueSetup(npcs, dialogueStage)
				end
			end
			faceObject(player.facing, staticObjects.overworld) -- still objects
			faceObject(player.facing, movingObjectData[currentLocation])
			if actionMode == 1 then
				if actions[1].k ~= 0 then
					resetAnims(objectAnimations, actions[1].k)
				end
				resetAnims(anim_act, player.facing)
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
