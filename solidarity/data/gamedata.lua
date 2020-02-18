titleScreen = 1
cursor = false
title = "Solidarity"
gameStage = 0
workStage = 2
keyInput = 1
freeze = {action = 0, dialogue = 0} -- 2 = stage freeze, 1 = energy too low, 0 = no freeze
--map
gridsize = 16
debugView = 0
infoView = 0
menuView = 0
noteMode = 0
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

-- if love.filesystem.isFused() then
--   local dir = love.filesystem.getSourceBaseDirectory()
--   local success = love.filesystem.mount(dir, "solidarity")
--
--   if success then
--
--   end
-- else
--   local dir = love.filesystem.getSource()
-- end



--images
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setColor(0, 0, 0)
  love.graphics.setBackgroundColor(255,255,255)

  titleFont = love.graphics.newFont("fonts/yoster-island.regular.ttf", 24)
  font = love.graphics.setNewFont("fonts/pixel.ttf", 8)

  -- scale for graphics
  scale = {x=4, y=4}

  -- titleImage = love.graphics.newImage("images/solidarity_title.png")
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
  portraitkey = {player = love.graphics.newQuad(0, 0, 46, 46, portraitsheet1:getDimensions()),
                 Fennel = love.graphics.newQuad(1*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Mint = love.graphics.newQuad(2*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Cress = love.graphics.newQuad(3*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Tarragon = love.graphics.newQuad(4*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Agave = love.graphics.newQuad(5*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Finch = love.graphics.newQuad(6*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Lark = love.graphics.newQuad(7*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Robin = love.graphics.newQuad(8*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Durian = love.graphics.newQuad(9*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Brier = love.graphics.newQuad(10*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Lotus = love.graphics.newQuad(11*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Euca = love.graphics.newQuad(12*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Hawk = love.graphics.newQuad(13*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Ani = love.graphics.newQuad(14*46, 0, 46, 46, portraitsheet1:getDimensions()),
                 Kousa = love.graphics.newQuad(0, 1*46, 46, 46, portraitsheet1:getDimensions()),
                 Tulsi = love.graphics.newQuad(1*46, 1*46, 46, 46, portraitsheet1:getDimensions())
                }
  currentspeaker = "player"
  uiSheet = love.graphics.newImage("images/solidarityui_16x16.png")
  uiSheetSm = love.graphics.newImage("images/solidarity_ui.png")
  uiQuadsSm = {arrowup = love.graphics.newQuad(0, 0, 8, 8, uiSheetSm:getDimensions()),
    arrowdown = love.graphics.newQuad(8, 0, 8, 8, uiSheetSm:getDimensions()),
    arrowright = love.graphics.newQuad(2*8, 0, 8, 8, uiSheetSm:getDimensions()),
    arrowleft = love.graphics.newQuad(3*8, 0, 8, 8, uiSheetSm:getDimensions()),
    pressz = love.graphics.newQuad(4*8, 0, 8, 8, uiSheetSm:getDimensions()),
    cornerLTop = love.graphics.newQuad(8, 8, 8, 8, uiSheetSm:getDimensions()),
    cornerRTop = love.graphics.newQuad(2*8, 8, 8, 8, uiSheetSm:getDimensions()),
    cornerLBottom = love.graphics.newQuad(3*8, 8, 8, 8, uiSheetSm:getDimensions()),
    cornerRBottom = love.graphics.newQuad(4*8, 8, 8, 8, uiSheetSm:getDimensions()),
    puarrowup = love.graphics.newQuad(5*8, 8, 8, 8, uiSheetSm:getDimensions()),
    puarrowdown = love.graphics.newQuad(6*8, 8, 8, 8, uiSheetSm:getDimensions()),
    trusthigh = love.graphics.newQuad(7*8, 8, 8, 8, uiSheetSm:getDimensions()),
    trustmed = love.graphics.newQuad(0, 2*8, 8, 8, uiSheetSm:getDimensions()),
    trustlow = love.graphics.newQuad(8, 2*8, 8, 8, uiSheetSm:getDimensions()),
    trustunknown = love.graphics.newQuad(2*8, 2*8, 8, 8, uiSheetSm:getDimensions()),
    coppercoin = love.graphics.newQuad(3*8, 2*8, 8, 8, uiSheetSm:getDimensions()),
    silvercoin = love.graphics.newQuad(4*8, 2*8, 8, 8, uiSheetSm:getDimensions()),
    goldcoin = love.graphics.newQuad(5*8, 2*8, 8, 8, uiSheetSm:getDimensions()),
    wharrowdown = love.graphics.newQuad(6*8, 2*8, 8, 8, uiSheetSm:getDimensions()),
    wharrowup = love.graphics.newQuad(7*8, 2*8, 8, 8, uiSheetSm:getDimensions()),
  }

  ui = {textboxbg = love.graphics.newImage("images/solidarity_textboxfull.png"),
      textboxbottom = love.graphics.newImage("images/solidarity_textboxbottom.png"),
      portraitbox = love.graphics.newImage("images/portrait_box_0.png"),
      portraitboxframe = love.graphics.newImage("images/portrait_box_1.png")
    }

  uiSwitches = {bedArrow = false}

  uiQuads =  {energyiconsquare = love.graphics.newQuad(0, 0, 16, 16, uiSheet:getDimensions()),
              energytextbg = love.graphics.newQuad(16, 0, 16, 16, uiSheet:getDimensions()),
              energytextbground = love.graphics.newQuad(2*16, 0, 16, 16, uiSheet:getDimensions()),
              speechbubblemedbot =  love.graphics.newQuad(3*16, 0, 16, 16, uiSheet:getDimensions()),
              speechbubblemedtop =  love.graphics.newQuad(4*16, 2*16, 16, 16, uiSheet:getDimensions()),
              energytextbgsmleft = love.graphics.newQuad(0, 16, 16, 16, uiSheet:getDimensions()),
              energytextbgsmright = love.graphics.newQuad(16, 16, 16, 16, uiSheet:getDimensions()),
              speechbubblelgbotleft = love.graphics.newQuad(2*16, 16, 16, 16, uiSheet:getDimensions()),
              speechbubblelgbotright = love.graphics.newQuad(3*16, 16, 16, 16, uiSheet:getDimensions()),
              energyiconcircle = love.graphics.newQuad(0, 2*16, 16, 16, uiSheet:getDimensions()),
              timeiconnight = love.graphics.newQuad(16, 2*16, 16, 16, uiSheet:getDimensions()),
              timeiconday = love.graphics.newQuad(2*16, 2*16, 16, 16, uiSheet:getDimensions()),
              timeiconevening = love.graphics.newQuad(3*16, 2*16, 16, 16, uiSheet:getDimensions()),
              energyboltlg = love.graphics.newQuad(0, 3*16, 16, 16, uiSheet:getDimensions()),
              energyboltsm = love.graphics.newQuad(16, 3*16, 16, 16, uiSheet:getDimensions()),
              itembg = love.graphics.newQuad(2*16, 3*16, 16, 16, uiSheet:getDimensions()),
              namebgL = love.graphics.newQuad(0, 4*16, 16, 16, uiSheet:getDimensions()),
              namebgM = love.graphics.newQuad(16, 4*16, 16, 16, uiSheet:getDimensions()),
              namebgR = love.graphics.newQuad(2*16, 4*16, 16, 16, uiSheet:getDimensions()),
              speechbubblesmbot = love.graphics.newQuad(3*16, 4*16, 16, 16, uiSheet:getDimensions()),
              speechbubblesmleft = love.graphics.newQuad(0, 5*16, 16, 16, uiSheet:getDimensions()),
              speechbubblesmright = love.graphics.newQuad(16, 5*16, 16, 16, uiSheet:getDimensions()),
              speechbubblesmtop = love.graphics.newQuad(2*16, 5*16, 16, 16, uiSheet:getDimensions()),
              menutablightL = love.graphics.newQuad(4*16, 0, 16, 16, uiSheet:getDimensions()),
              menutablightM = love.graphics.newQuad(5*16, 0, 16, 16, uiSheet:getDimensions()),
              menutablightR = love.graphics.newQuad(6*16, 0, 16, 16, uiSheet:getDimensions()),
              menutabdarkL = love.graphics.newQuad(4*16, 16, 16, 16, uiSheet:getDimensions()),
              menutabdarkM = love.graphics.newQuad(5*16, 16, 16, 16, uiSheet:getDimensions()),
              menutabdarkR = love.graphics.newQuad(6*16, 16, 16, 16, uiSheet:getDimensions())
              }

  bubble = {x = 0, y = 0, on = 0, obj = "", timer = 0, static = 0, type = 1}

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

  menu = {currentTab = "inventory",
  allTabs = {"inventory", "map2", "map1", "journal"},
  tabData = {inventory = {text = "Inventory", x = 0, c = 8, r = 1}, map2 = {text = "Island Map", x = 64}, map1 = {text = "Journal", x = 0, c = 5, r = 3}},
  position = {1, 1, 1, 1},
  grid = {1, 1},
  total = 3,
  tabNum = 2}

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
                       platefull3 = love.graphics.newQuad(13*gridsize, 0, 16, 16, animsheet3:getDimensions()),
                       fenceopenL = love.graphics.newQuad(9*gridsize, 0, 16, 16, animsheet3:getDimensions()),
                       fenceopenR = love.graphics.newQuad(10*gridsize, 0, 16, 16, animsheet3:getDimensions()),
                       fenceclosedL = love.graphics.newQuad(11*gridsize, 0, 16, 16, animsheet3:getDimensions()),
                       fenceclosedR = love.graphics.newQuad(12*gridsize, 0, 16, 16, animsheet3:getDimensions()),
                       playerSleepClosed = love.graphics.newQuad(0, 1*gridsize, 16, 16, animsheet3:getDimensions()),
                       playerSleepOpen = love.graphics.newQuad(0, 2*gridsize, 16, 16, animsheet3:getDimensions()),
                       fennelSleepClosed = love.graphics.newQuad(1*gridsize, 1*gridsize, 16, 16, animsheet3:getDimensions()),
                       fennelSleepOpen = love.graphics.newQuad(1*gridsize, 2*gridsize, 16, 16, animsheet3:getDimensions()),
                       mintSleepClosed = love.graphics.newQuad(2*gridsize, 1*gridsize, 16, 16, animsheet3:getDimensions()),
                       mintSleepOpen = love.graphics.newQuad(2*gridsize, 2*gridsize, 16, 16, animsheet3:getDimensions()),
                       durianSleepClosed = love.graphics.newQuad(3*gridsize, 1*gridsize, 16, 16, animsheet3:getDimensions()),
                       durianSleepClosed = love.graphics.newQuad(3*gridsize, 2*gridsize, 16, 16, animsheet3:getDimensions())
                      }

animsheet1 = love.graphics.newImage("images/solidarity_anim.png")
animsheet_act = love.graphics.newImage("images/solidarity_anim_act.png")

charanimations = {player = {walk = {{anim = newAnimation(animsheet1, 0, 4, 16, 16, .50), name = "up", loop = 0},
                        {anim = newAnimation(animsheet1, 1*16, 4, 16, 16, .50), name = "down", loop = 0},
                        {anim = newAnimation(animsheet1, 2*16, 4, 16, 16, .55), name = "left", loop = 0},
                        {anim = newAnimation(animsheet1, 3*16, 4, 16, 16, .55), name = "right", loop = 0}},
        act = {{anim = newAnimation(animsheet_act, 0, 4, 16, 16, .4), name = "up", loop = 1, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 1*16, 4, 16, 16, .4), name = "down", loop = 1, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 2*16, 4, 16, 16, .4), name = "left", loop = 1, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 3*16, 4, 16, 16, .4), name = "right", loop = 1, current = 0, running = 0, count = 0}}
            },
    }
--characters
player = {
  grid_x = 17*gridsize,
  grid_y = 23*gridsize,
  act_x = 17*gridsize,
  act_y = 23*gridsize,
  path = {{x = 0, y = 0}, {x = 0, y = 0}},
  newDir = 0,
  speed = 48,
  canMove = 1,
  moveDir = 0,
  threshold = 0.02,
  facing = 2,
  name = "Saffron",
  battlestats = {maxhp = 2, damage = 1, moves = 2},
  inventory = {},
  maxInventory = 6,
  party = {},
  showParty = false,
  leaveParty = false,
  spells = {},
  energy = 100,
  quota = 60,
  sleep = false,
  money = {current = {c = 0, s = 0, g = 0}, next = {c = 5, s = 0, g = 0}},
  actions = {current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0, index = 0},
  next = {{x = 0, y = 0, facing = 0, location = "overworld"},
          {x = 0, y = 0, facing = 0, location = "dininghall"},
          {x = 14*gridsize, y = 16*gridsize, facing = 3, location = "dormitory"},
          {x = 0, y = 0, facing = 0, location = "dormitory"},
          {x = 0, y = 0, facing = 0, location = "overworld"},
          {x = 0, y = 0, facing = 0, location = "dininghall"},
          {x = 24*gridsize, y = 12*gridsize, facing = 4, location = "overworld"},
          {x = 0, y = 0, facing = 0, location = "overworld"},
        },

}

npcs = {{
  grid_x = 18*gridsize,
  grid_y = 30*gridsize,
  act_x = 18*gridsize,
  act_y = 30*gridsize,
  path = {{x = 0, y = 0}, {x = 0, y = 0}},
  speed = 30,
  canMove = 0,
  moveDir = 0,
  threshold = 0,
  facing = 1, --direction currently facing
  start = 1, --direction facing when starting
  randomturn = 0, --randomly faces different directions
  working = 1, -- use action anims
  canWork = 1,
  leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
  leaveParty = {{facing = 1, x = 18*gridsize, y = 30*gridsize, canWork = 1}},
  timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
  location = "overworld",
  dialogue = 0, -- curently in dialogue
  mapping = {added = 0, dialogueCount = 0, lvl = "?"},
  info = {pos = "Field Hand", time = 4, notes = "", comp = "Berry Fields"},
  name = "Fennel",
  status = "worker",
  n = 1, --stage in single conversation
  c = 1, -- dialogue case
  stats = {trust = {player = 80, Mint = 80, Finch = 0, Lark = 0, Cress = 70, Agave = 60, Tarragon = 5, Robin = 5, Durian = 5},
          battlestats = {maxhp = 2, damage = 1, moves = 3}
  },
  actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
  next = {{x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
          {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
          {x = 13*gridsize, y = 16*gridsize, facing = 4, location = "dormitory", canWork = 0},
          {x = 16*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
          {x = 13*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
          {x = 13*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
          {x = 16*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
          {x = 16*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
        },
  animations = {walk = {{anim = newAnimation(animsheet1, 4*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                        {anim = newAnimation(animsheet1, 5*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                        {anim = newAnimation(animsheet1, 6*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                        {anim = newAnimation(animsheet1, 7*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
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
    path = {{x = 0, y = 0}, {x = 0, y = 0}},
    speed = 30,
    canMove = 0,
    moveDir = 0,
    threshold = 0,
    facing = 1,
    start = 2,
    randomturn = 0, --randomly faces different directions
    working = 1, -- use action anims
    canWork = 1,
    leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
    leaveParty = {{facing = 1, x = 18*gridsize, y = 30*gridsize, canWork = 0},
                  {facing = 1, x = 14*gridsize, y = 14*gridsize, canWork = 0}},
    timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
    location = "overworld",
    dialogue = 0,
    mapping = {added = 0, dialogueCount = 0, lvl = "?"},
    info = {pos = "Field Hand", time = 7, notes = "", comp = "Berry Fields"},
    name = "Mint", --2
    status = "worker",
    n = 1,
    c = 1,
    stats = {trust = {player = 60, Fennel = 80, Finch = 5, Lark = 5, Cress = 60, Agave = 70, Tarragon = 5, Robin = 5, Durian = 5},
            battlestats = {maxhp = 2, damage = 1, moves = 3}
          },
    actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
    next = {{x = 21*gridsize, y = 23*gridsize, facing = 2, location = "overworld", canWork = 1},
            {x = 21*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0},
            {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
            {x = 21*gridsize, y = 23*gridsize, facing = 2, location = "overworld", canWork = 1},
            {x = 0, y = 0, facing = 0, location = "overworld", canWork = 0},
            {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
            {x = 21*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0},
            {x = 21*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0},
          },
    animations = {walk = {{anim = newAnimation(animsheet1, 8*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                          {anim = newAnimation(animsheet1, 9*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                          {anim = newAnimation(animsheet1, 10*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                          {anim = newAnimation(animsheet1, 11*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
            act = {{anim = newAnimation(animsheet_act, 8*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
            {anim = newAnimation(animsheet_act, 9*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
            {anim = newAnimation(animsheet_act, 10*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
            {anim = newAnimation(animsheet_act, 11*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
          }
    },
    {
      grid_x = 21*gridsize,
      grid_y = 26*gridsize,
      act_x = 21*gridsize,
      act_y = 26*gridsize,
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
      speed = 30,
      canMove = 0,
      moveDir = 0,
      threshold = 0,
      facing = 1,
      start = 1,
      randomturn = 0,
      working = 1,
      canWork = 1,
      leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
      leaveParty = {{facing = 1, x = 21*gridsize, y = 26*gridsize, canWork = 1}},
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
      location = "overworld",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Field Hand", time = 2, notes = "", comp = "Berry Fields"},
      name = "Cress", -- 5
      status = "worker",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 50, Mint = 70, Fennel = 50, Finch = 0, Lark = 0, Agave = 40, Tarragon = 10, Robin = 5, Durian = 10},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 14*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 14*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 20*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 21*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 22*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 23*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
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
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
      speed = 25,
      canMove = 0,
      moveDir = 0,
      threshold = 0,
      facing = 1,
      start = 2,
      randomturn = 0,
      working = 0,
      canWork = 0,
      leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
      leaveParty = {{facing = 1, x = 13*gridsize, y = 31*gridsize, canWork = 0}},
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
      location = "overworld",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Field Hand", notes = "", comp = "Berry Fields"},
      name = "Agave", --6
      status = "worker",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 70, Mint = 70, Fennel = 70, Finch = 0, Lark = 0, Cress = 70, Tarragon = 70, Robin = 45, Durian = 60},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
            },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 18*gridsize, y = 19*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 13*gridsize, y = 31*gridsize, facing = 2, location = "overworld", canWork = 0},
              {x = 23*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
              {x = 23*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
              {x = 14*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 14*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
            },
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
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
      speed = 30,
      canMove = 0,
      moveDir = 0,
      threshold = 0,
      facing = 1,
      start = 2,
      randomturn = 0,
      working = 0,
      canWork = 0,
      leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
      location = "overworld",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Field Hand", notes = "", comp = "Berry Fields"},
      name = "Tarragon", --7
      status = "worker",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 15, Mint = 30, Fennel = 10, Finch = 0, Lark = 0, Cress = 20, Agave = 30, Robin = 45, Durian = 70},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 26*gridsize, y = 16*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 26*gridsize, y = 16*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 21*gridsize, y = 31*gridsize, facing = 2, location = "overworld", canWork = 0},
              {x = 17*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
              {x = 17*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
              {x = 26*gridsize, y = 16*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 26*gridsize, y = 16*gridsize, facing = 2, location = "dormitory", canWork = 0},
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 28*16, 4, 16, 16, .5), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 29*16, 4, 16, 16, .5), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 30*16, 4, 16, 16, .55), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 31*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
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
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
      speed = 30,
      canMove = 0,
      moveDir = 0,
      threshold = 0,
      facing = 1,
      start = 2,
      randomturn = 0,
      working = 1,
      canWork = 1,
      leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
      location = "overworld",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Field Hand", notes = "", comp = "Berry Fields"},
      name = "Robin", --8
      status = "worker",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 10, Mint = 20, Fennel = 5, Finch = 30, Lark = 40, Cress = 10, Agave = 10, Tarragon = 50, Durian = 70},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 28*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 28*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 14*gridsize, y = 27*gridsize, facing = 2, location = "overworld", canWork = 1},
              {x = 17*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 17*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 28*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 28*gridsize, y = 13*gridsize, facing = 2, location = "dormitory", canWork = 0},
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 32*16, 4, 16, 16, .5), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 33*16, 4, 16, 16, .5), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 34*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 35*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
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
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
      speed = 30,
      canMove = 0,
      moveDir = 0,
      threshold = 0,
      facing = 1,
      start = 2,
      randomturn = 0,
      working = 0,
      canWork = 0,
      leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc., current time, max time, wait time
      location = "offscreen",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Field Hand", notes = "", comp = "Berry Fields"},
      name = "Durian", --9
      status = "worker",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 20, Mint = 30, Fennel = 10, Finch = 5, Lark = 0, Cress = 15, Agave = 20, Tarragon = 60, Robin = 80},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
            },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 27*gridsize, y = 14*gridsize, facing = 4, location = "dormitory", canWork = 0},
              {x = 27*gridsize, y = 14*gridsize, facing = 4, location = "dormitory", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 14*gridsize, y = 16*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 18*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
              {x = 18*gridsize, y = 14*gridsize, facing = 1, location = "dininghall", canWork = 0},
              {x = 27*gridsize, y = 14*gridsize, facing = 4, location = "dormitory", canWork = 0},
              {x = 27*gridsize, y = 14*gridsize, facing = 4, location = "dormitory", canWork = 0},
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 36*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 37*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 38*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 39*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
              act = {{anim = newAnimation(animsheet_act, 36*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 37*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 38*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 39*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
            }
    },
    {
      grid_x = 0*gridsize,
      grid_y = 0*gridsize,
      act_x = 0*gridsize,
      act_y = 0*gridsize,
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
      speed = 30,
      canMove = 0,
      moveDir = 0,
      threshold = 0,
      facing = 1,
      start = 2,
      randomturn = 0,
      working = 0,
      canWork = 0,
      leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
      leaveParty = {{facing = 1, x = 13*gridsize, y = 31*gridsize, canWork = 0}},
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc., current time, max time, wait time
      location = "offscreen",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Dorm Supervisor", notes = "", comp = "Berry Fields"},
      name = "Brier", --9
      status = "worker",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 20, Mint = 30, Fennel = 10, Finch = 5, Lark = 0, Cress = 15, Agave = 20, Tarragon = 60, Robin = 80},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 25*gridsize, y = 9*gridsize, facing = 1, location = "dormitory", canWork = 0},
              {x = 25*gridsize, y = 37*gridsize, facing = 2, location = "overworld", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 24*gridsize, y = 9*gridsize, facing = 1, location = "dormitory", canWork = 0},
              {x = 23*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 23*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 25*gridsize, y = 9*gridsize, facing = 1, location = "dormitory", canWork = 0},
              {x = 25*gridsize, y = 9*gridsize, facing = 1, location = "dormitory", canWork = 0},
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 40*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 41*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 42*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 43*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
              act = {{anim = newAnimation(animsheet_act, 40*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 41*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 42*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 43*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
            }
    },
    {
      grid_x = 0*gridsize,
      grid_y = 0*gridsize,
      act_x = 0*gridsize,
      act_y = 0*gridsize,
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
      speed = 30,
      canMove = 0,
      moveDir = 0,
      threshold = 0,
      facing = 1,
      start = 2,
      randomturn = 0,
      working = 0,
      canWork = 0,
      leaveControl = {moving = 0, path = {}, noden = 1, n = 1},
      leaveParty = {{facing = 1, x = 15*gridsize, y = 14*gridsize}},
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc., current time, max time, wait time
      location = "offscreen",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Field Hand", notes = "", comp = "Berry Fields"},
      name = "Lotus", --9
      status = "worker",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 20, Mint = 30, Fennel = 10, Finch = 10, Lark = 10, Cress = 15, Agave = 20, Tarragon = 60, Robin = 80},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 14*gridsize, y = 10*gridsize, facing = 2, location = "overworld", canWork = 0},
              {x = 10*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 14*gridsize, y = 14*gridsize, facing = 2, location = "overworld", canWork = 0},
              {x = 22*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 22*gridsize, y = 12*gridsize, facing = 2, location = "dininghall", canWork = 0},
              {x = 10*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0},
              {x = 10*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0},
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 44*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 45*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 46*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 47*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
              act = {{anim = newAnimation(animsheet_act, 44*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 45*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 46*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 47*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
            }
    },
    {
      grid_x = 18*gridsize,
      grid_y = 9*gridsize,
      act_x = 18*gridsize,
      act_y = 9*gridsize,
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
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
      location = "dininghall",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Cook", notes = "", comp = "Berry Fields"},
      name = "Euca",
      status = "worker",
      offset = {location = "dininghall", x = 0, y = 16},
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 15, Mint = 15, Fennel = 20, Finch = 5, Lark = 0, Cress = 15, Agave = 15, Tarragon = 10, Robin = 10},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 25*gridsize, y = 12*gridsize, facing = 3, location = "overworld", canWork = 0},
              {x = 25*gridsize, y = 12*gridsize, facing = 3, location = "offscreen", canWork = 0}
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 48*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 49*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 50*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 51*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
              act = {{anim = newAnimation(animsheet_act, 48*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 49*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 50*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 51*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
            }
    },
    {
      grid_x = 16*gridsize,
      grid_y = 21*gridsize,
      act_x = 16*gridsize,
      act_y = 21*gridsize,
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
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
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Guard", notes = "", comp = "Berry Fields"},
      name = "Finch", --4
      status = "boss",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 5, Mint = 5, Fennel = 5, Lark = 70, Cress = 5, Agave = 0, Tarragon = 5, Robin = 30, Durian = 5},
              battlestats = {maxhp = 3, damage = 1, moves = 1}
            },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 16*gridsize, y = 21*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 16*gridsize, y = 20*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 16*gridsize, y = 21*gridsize, facing = 4, location = "gardeningShed", canWork = 0},
              {x = 16*gridsize, y = 21*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 16*gridsize, y = 20*gridsize, facing = 4, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0}
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 12*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 13*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 14*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 15*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
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
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
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
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Foreman", notes = "", comp = "Berry Fields"},
      name = "Lark", -- 3
      status = "boss",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 10, Mint = 10, Fennel = 10, Finch = 80, Agave = 10, Tarragon = 10, Robin = 20, Durian = 10},
              battlestats = {maxhp = 5, damage = 1,  moves = 2}
            },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 10*gridsize, y = 27*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 10*gridsize, y = 27*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 10*gridsize, y = 27*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 16*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 17*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 18*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 19*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
              act = {{anim = newAnimation(animsheet_act, 16*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 17*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 18*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 19*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
            }
    },
    {
      grid_x = 14*gridsize,
      grid_y = 10*gridsize,
      act_x = 14*gridsize,
      act_y = 10*gridsize,
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
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
      location = "dininghall",
      dialogue = 0,
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Guard", notes = "", comp = "Berry Fields"},
      name = "Hawk",
      status = "boss",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 20, Mint = 30, Fennel = 10, Finch = 5, Lark = 0, Cress = 15, Agave = 20, Tarragon = 60, Robin = 80},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "dininghall", canWork = 0}
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 52*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 53*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 54*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 55*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
              act = {{anim = newAnimation(animsheet_act, 52*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 53*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 54*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 55*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
            }
    },
    {
      grid_x = 23*gridsize,
      grid_y = 20*gridsize,
      act_x = 23*gridsize,
      act_y = 20*gridsize,
      path = {{x = 0, y = 0}, {x = 0, y = 0}},
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
      mapping = {added = 0, dialogueCount = 0, lvl = "?"},
      info = {pos = "Manager", notes = "", comp = "Berry Fields"},
      name = "Ani",
      status = "boss",
      n = 1, --stage in single conversation
      c = 1,
      stats = {trust = {player = 20, Mint = 30, Fennel = 10, Finch = 5, Lark = 0, Cress = 15, Agave = 20, Tarragon = 60, Robin = 80},
              battlestats = {maxhp = 3, damage = 1,  moves = 1}
      },
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 0, y = 0, facing = 0, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "offscreen", canWork = 0},
              {x = 23*gridsize, y = 20*gridsize, facing = 1, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 2, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 2, location = "offscreen", canWork = 0},
              {x = 0, y = 0, facing = 2, location = "offscreen", canWork = 0}
            },
      animations = {walk = {{anim = newAnimation(animsheet1, 56*16, 4, 16, 16, .5 ), name = "up", loop = 0},
                            {anim = newAnimation(animsheet1, 57*16, 4, 16, 16, .5 ), name = "down", loop = 0},
                            {anim = newAnimation(animsheet1, 58*16, 4, 16, 16, .55 ), name = "left", loop = 0},
                            {anim = newAnimation(animsheet1, 59*16, 4, 16, 16, .55 ), name = "right", loop = 0}},
              act = {{anim = newAnimation(animsheet_act, 52*16, 4, 16, 16, .6), name = "up", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 53*16, 4, 16, 16, .6), name = "down", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 54*16, 4, 16, 16, .6), name = "left", loop = 0, current = 0, running = 0, count = 0},
              {anim = newAnimation(animsheet_act, 55*16, 4, 16, 16, .6), name = "right", loop = 0, current = 0, running = 0, count = 0}}
            }
    }
}

trustTable =
{
  {"", "player", "Fennel", "Mint", "Cress", "Agave", "Tarragon", "Robin", "Durian", "Brian", "Lotus", "Euca", "Finch", "Lark", "Hawk", "Ani"},
  {"player", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Fennel", 80, 100, 80, 70, 60, 5, 5, 5, 30, 30, 50, 0, 0, 0, 10},
  {"Mint", 60, 80, 100, 60, 70, 5, 5, 5, 30, 40, 80, 5, 5, 5, 5},
  {"Cress", 50, 70, 30, 100, 40, 10, 0, 5, 40, 40, 50, 5, 0, 5, 10},
  {"Agave", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Tarragon", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Robin", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Durian", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Brian", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Lotus", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Euca", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Finch", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Lark", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Hawk", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100},
  {"Ani", 100, 80, 70, 60, 70, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100}
}
socialMap = {}

storedLocation = {x = 0, y = 0}
storedIndex = {0}
specialCoords = {{stage = 1, x = 17*gridsize, y = 20*gridsize, char = player, triggered = 0}}

-- actions
actionMode = 0
usedItem = 0
actions = {player = {current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0, index = 0}
          }
--battle
battleMode = 0
battleGlobal = {maxmoves = #player.party + 2, movesTaken = 0, turn = 0, phase = 0}

require("scripts/battle")
--object text index for background objects
staticObjects = {
  overworld = {
    gardeningSign = {{x = 16*gridsize, y = 17*gridsize}},
    kitchenSign = {{x = 23*gridsize, y = 17*gridsize}},
    dormitorySign = {{x = 29*gridsize, y = 26*gridsize}},
    storeSign = {{x = 29*gridsize, y = 34*gridsize}},
    gardeningShed = {
      {x = locationTriggers.overworld[1].x, y = locationTriggers.overworld[1].y, visible = 0}
    },
    dormitory = {
      {x = locationTriggers.overworld[2].x, y = locationTriggers.overworld[2].y, visible = 0},
      {x = locationTriggers.overworld[3].x, y = locationTriggers.overworld[3].y, visible = 0}
    },
    dininghall = {
      {x = locationTriggers.overworld[4].x, y = locationTriggers.overworld[4].y, visible = 0},
      {x = locationTriggers.overworld[5].x, y = locationTriggers.overworld[5].y, visible = 0}
    },
    store = {
      {x = locationTriggers.overworld[6].x, y = locationTriggers.overworld[6].y, visible = 0}
    }
  },
  dormitory = {
      playerBed = {{x = 15*gridsize, y = 16*gridsize}},
      LotusBed = {{x = 9*gridsize, y = 16*gridsize}},
      CressBed = {{x = 9*gridsize, y = 9*gridsize}},
      AgaveBed = {{x = 15*gridsize, y = 9*gridsize}},
      FennelBed = {{x = 15*gridsize, y = 13*gridsize}, {x = 15*gridsize, y = 12*gridsize}},
      MintBed = {{x = 21*gridsize, y = 16*gridsize}},
      DurianBed = {{x = 24*gridsize, y = 12*gridsize}, {x = 24*gridsize, y = 13*gridsize}},
      RobinBed = {{x = 27*gridsize, y = 12*gridsize}, {x = 27*gridsize, y = 13*gridsize}},
      TarragonBed = {{x = 27*gridsize, y = 16*gridsize}},
      BrierBed = {{x = 27*gridsize, y = 9*gridsize}},
    }
}

objectInventory = {barrelSmBerries = 0, barrelLgBerries = 0}

itemStats = {plantSmBerries = {max = 60, stackable = 1},
            plantLgBerries = {max = 60, stackable = 1},
            platefull2 = {max = 60, stackable = 0, use = "Eat"},
            platefull3 = {max = 60, stackable = 0, use = "Eat"}
            }
itemText = ""
animsheet2 = love.graphics.newImage("images/solidarity_object_anim.png")
movingObjectData = {overworld =
                      {plantSmBerries = {
                          {x = 11*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 12*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 13*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 14*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 15*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 18*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 19*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 20*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 21*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 22*gridsize, y = 24*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 11*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 12*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 13*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 15*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 18*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 19*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 20*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 21*gridsize, y = 25*gridsize, visible = 1, anim = newAnimation(animsheet2, 0, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0}
                        },
                      plantSm = {
                          {x = 14*gridsize, y = 25*gridsize, visible = 1, anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantSm}}, loop = 1, current = 0, running = 0, count = 0},
                          {x = 22*gridsize, y = 25*gridsize, visible = 1, anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantSm}}, loop = 1, current = 0, running = 0, count = 0}
                        },
                      plantLgBerries = {
                          {x = 11*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 12*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 13*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 14*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 18*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 19*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 20*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 21*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 22*gridsize, y = 28*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 11*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 13*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 14*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 15*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 18*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 19*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 20*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 21*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0},
                          {x = 22*gridsize, y = 29*gridsize, visible = 1, anim = newAnimation(animsheet2, 4*16, 3, 16, 16, .3), loop = 1, current = 0, running = 0, count = 0, used = 0, picked = 0, trigger = 0}
                        },
                      plantLg = {
                          {x = 15*gridsize, y = 28*gridsize, visible = 1, anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantLg}}, loop = 1, current = 0, running = 0, count = 0},
                          {x = 12*gridsize, y = 29*gridsize, visible = 1, anim = {spriteSheet = animsheet3, quads = {movingObjectQuads.plantLg}}, loop = 1, current = 0, running = 0, count = 0}
                      },
                      barrelSmBerries = {
                          {x = 15*gridsize, y = 22*gridsize, visible = 1, anim = newAnimation(animsheet2, 10*16, 4, 16, 16, .3), loop = 2, current = 0, running = 0, count = 0}
                        },
                      barrelLgBerries = {
                          {x = 18*gridsize, y = 22*gridsize, visible = 1, anim = newAnimation(animsheet2, 11*16, 4, 16, 16, .3), loop = 2, current = 0, running = 0, count = 0}
                        }
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
                                        {x = 12*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 13*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 14*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 17*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 18*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 19*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 22*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 23*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 24*gridsize, y = 12*gridsize, visible = 1},
                                        {x = 12*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 13*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 14*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 17*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 18*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 19*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 22*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 23*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 24*gridsize, y = 14*gridsize, visible = 1},
                                        {x = 12*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 13*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 14*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 17*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 18*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 19*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 22*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 23*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 24*gridsize, y = 16*gridsize, visible = 1},
                                        {x = 12*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 13*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 14*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 17*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 18*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 19*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 22*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 23*gridsize, y = 18*gridsize, visible = 1},
                                        {x = 24*gridsize, y = 18*gridsize, visible = 1}
                                    }
                                  },
                        dormitory = {
                                    playerSleepClosed = {
                                      {x = 15*gridsize, y = 16*gridsize, visible = 0},
                                    },
                                    playerSleepOpen = {
                                      {x = 15*gridsize, y = 16*gridsize, visible = 0},
                                    },
                                    fennelSleepClosed = {
                                      {x = 15*gridsize, y = 12*gridsize, visible = 0},
                                    },
                                    fennelSleepOpen = {
                                      {x = 15*gridsize, y = 12*gridsize, visible = 0},
                                    },
                                    mintSleepClosed = {
                                      {x = 15*gridsize, y = 12*gridsize, visible = 0},
                                    },
                                    mintSleepOpen = {
                                      {x = 15*gridsize, y = 12*gridsize, visible = 0},
                                    },
                                  },
                        }


-- tiles that are rendered on top of the player and npcs
toptilesSheet = love.graphics.newImage("images/solidarity_toptiles.png")
toptiles = {doorway = love.graphics.newQuad(0, 0, 16, 16, toptilesSheet:getDimensions()),
            black = love.graphics.newQuad(1*gridsize, 0, 16, 16, toptilesSheet:getDimensions()),
            doorL = love.graphics.newQuad(2*gridsize, 0, 16, 16, toptilesSheet:getDimensions()),
            doorR = love.graphics.newQuad(3*gridsize, 0, 16, 16, toptilesSheet:getDimensions())
            }
toptileData = {gardeningShed = {
                                doorway = {{x = locationTriggers.gardeningShed[1].x, y = locationTriggers.gardeningShed[1].y, visible = 1}},
                                doorL = {{x = locationTriggers.gardeningShed[1].x-gridsize, y = locationTriggers.gardeningShed[1].y, visible = 1}},
                                doorR = {{x = locationTriggers.gardeningShed[1].x+gridsize, y = locationTriggers.gardeningShed[1].y, visible = 1}}
                               },
              dormitory = {
                          doorway = {{x= locationTriggers.dormitory[1].x, y = locationTriggers.dormitory[1].y, visible = 1},
                                      {x= locationTriggers.dormitory[2].x, y = locationTriggers.dormitory[2].y, visible = 1}
                                    },
                          doorL = {{x= locationTriggers.dormitory[1].x-gridsize, y = locationTriggers.dormitory[1].y, visible = 1},
                                   {x = locationTriggers.dormitory[2].x-gridsize, y = locationTriggers.dormitory[2].y, visible = 1},
                                 },
                          doorR = {{x = locationTriggers.dormitory[1].x+gridsize, y = locationTriggers.dormitory[1].y, visible = 1},
                                   {x = locationTriggers.dormitory[2].x+gridsize, y = locationTriggers.dormitory[2].y, visible = 1}
                                  }
                          },
              dininghall = {
                            doorway = {{ x= locationTriggers.dininghall[1].x, y = locationTriggers.dininghall[1].y, visible = 1},
                                       {x= locationTriggers.dininghall[2].x, y = locationTriggers.dininghall[2].y, visible = 1}
                                     },
                            doorL = {{x= locationTriggers.dininghall[1].x-gridsize, y = locationTriggers.dininghall[1].y, visible = 1},
                                     {x= locationTriggers.dininghall[2].x-gridsize, y = locationTriggers.dininghall[2].y, visible = 1}
                                   },
                            doorR = {{x= locationTriggers.dininghall[1].x+gridsize, y = locationTriggers.dininghall[1].y, visible = 1},
                                     {x= locationTriggers.dininghall[2].x+gridsize, y = locationTriggers.dininghall[2].y, visible = 1}
                                    }
                          },
              store = {doorway = {{x= locationTriggers.store[1].x, y = locationTriggers.store[1].y, visible = 1}
                                 }
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

coords = {{grid_x = 19*gridsize, grid_y = 11*gridsize, act_x = 18*gridsize, act_y = 11*gridsize, facing = 2}}
cutsceneControl = {stage = 0, total = 9, current = 1}
-- types: 1 = talk, 2 = changeScene


cutsceneList ={{
  triggered = false,
  type = 1, -- npc talks to you
  move = true, --does the NPC move?
  npc = "Lark", --which NPC
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
  switchTime = 2, -- what time of day is it after the end
  workStage = 3, -- settings for gate, pushback, etc.
  next = 2,
},
{
  triggered = false,
  type = 1, -- npc talks to you
  move = true, --does the NPC move?
  npc = "Agave", --which NPC
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
  switchTime = 2, -- what time of day is it after the end
  workStage = 4, -- settings for gate, pushback, etc.
  next = 3,
},
{
  triggered = false,
  type = 0, -- sleep
  fadeout = 1,
  black = 1,
  skipnext = true, -- do we go directly to next cutscene?
  nextStage = true, -- do we go to the next game scene
  switchTime = 3, -- what time of day is it after the end
  workStage = 4, -- settings for gate, pushback, etc.
  next = 4,
},
{
  triggered = false,
  type = 1, -- npc talks
  move = false, --does the NPC move?
  npc = "Fennel", --which NPC
  dialoguekey = 1,
  fadeout = 3,
  black = 1,
  skipnext = false, -- do we go directly to next cutscene?
  nextStage = true, -- do we go to the next game scene
  switchTime = 1, -- what time of day is it after the end
  workStage = 4, -- settings for gate, pushback, etc.
  next = 5,
},
{
  triggered = false,
  type = 1, -- npc talks
  move = false, --does the NPC move?
  forcetalk = true,
  npc = "Lark", --which NPC
  dialoguekey = 2,
  fadeout = 1,
  black = 1,
  skipnext = true, -- do we go directly to next cutscene?
  nextStage = true,
  switchTime = 0, -- what time of day is it after the end
  workStage = 3, -- settings for gate, pushback, etc.
  next = 6,
},
{
  triggered = false,
  type = 1, -- npc talks to you
  move = true, --does the NPC move?
  npc = "Mint", --which NPC
  target = player, -- where do they move
  facing = {1}, --what direction are they facing at the end
  noden = 1, --what node are they walking to next
  dialoguekey = 1,
  path = {},
  fadeout = 0,
  black = 0,
  goback = false, -- npc goes back to starting position
  skipnext = false, -- do we go directly to next cutscene?
  nextStage = false, -- do we go to the next game scene
  switchTime = 0, -- what time of day is it after the end
  workStage = 4, -- settings for gate, pushback, etc.
  next = 7,
},
{
  triggered = false,
  type = 1, -- npc talks
  move = true, --does the NPC move?
  forcetalk = true,
  npc = "Ani", --which NPC
  targetIndex = 1,
  target = coords[1], -- where do they move
  facing = {2}, --what direction are they facing at the end
  noden = 1,
  dialoguekey = 1,
  path = {},
  fadeout = 0,
  black = 0,
  goback = true,
  skipnext = false, -- do we go directly to next cutscene?
  nextStage = true,
  switchTime = 2, -- what time of day is it after the end
  workStage = 4, -- settings for gate, pushback, etc.
  next = 8,
},
{
  triggered = false,
  type = 1, -- npc talks to you
  move = true, --does the NPC move?
  npc = "Euca", --which NPC
  target = player, -- where do they move
  facing = {1}, --what direction are they facing at the end
  noden = 1, --what node are they walking to next
  dialoguekey = 5,
  path = {},
  fadeout = 1,
  black = 1,
  goback = false, -- npc goes back to starting position
  skipnext = true, -- do we go directly to next cutscene?
  nextStage = true, -- do we go to the next game scene
  switchTime = 2, -- what time of day is it after the end
  workStage = 4, -- settings for gate, pushback, etc.
  next = 9,
},
{
  triggered = false,
  type = 1, -- npc talks to you
  move = false, --does the NPC move?
  npc = "Euca", --which NPC
  forcetalk = true,
  target = player, -- where do they move
  facing = {1}, --what direction are they facing at the end
  noden = 1, --what node are they walking to next
  dialoguekey = 1,
  path = {},
  fadeout = 1,
  black = 1,
  goback = false, -- npc goes back to starting position
  skipnext = true, -- do we go directly to next cutscene?
  nextStage = false, -- do we go to the next game scene
  switchTime = 2, -- what time of day is it after the end
  workStage = 4, -- settings for gate, pushback, etc.
  next = 9,
},
}


--dialogue

dialogueMode = 0
dialogueStage = 0
choice = {mode = 0, pos = 1, total = 1, name = "", case = 0, more = 0, type = ""}
text = nil
textsub = ""
textn = 0
trigger = {0}
wait = {start = .8, rate = 1, current = 0, triggered = 0, n = 0}

--timer for blinking text/images
timer = {{base = .5, current = 0, trigger = 0}, -- blinking arrow
          {base = .03, current = 0, trigger = 0}} --unrolling text


--audio
sfx = {berryPickup = love.audio.newSource("audio/berrypickup.wav", "static"),
      berryPickup2 = love.audio.newSource("audio/berrypickup2.wav", "static"),
      berryDrop = love.audio.newSource("audio/berrydrop.wav", "static"),
      textSelect = love.audio.newSource("audio/menu_select.wav", "static")
}

music ={overworld = love.audio.newSource("audio/8Bit_ghibli_1.wav")}

masterVolume = 0.5 -- Maximum volume for all sounds
effectVolume = 0.75
musicVolume = 1


-- save files
save = {total = 0, current = 0, name = ""}
