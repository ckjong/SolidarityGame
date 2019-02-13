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
  actions = {current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0, index = 0},
  next = {{x = 0, y = 0, facing = 0, location = "overworld"},
          {x = 0, y = 0, facing = 0, location = "dininghall"}},
  animations = {walk = {{anim = newAnimation(animsheet1, 0, 4, 16, 16, .50), name = "up", loop = 0},
                        {anim = newAnimation(animsheet1, 1*16, 4, 16, 16, .50), name = "down", loop = 0},
                        {anim = newAnimation(animsheet1, 2*16, 4, 16, 16, .55), name = "left", loop = 0},
                        {anim = newAnimation(animsheet1, 3*16, 4, 16, 16, .55), name = "right", loop = 0}},
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
  actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
  next = {{x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0},
          {x = 0, y = 0, facing = 1, location = "offscreen", canWork = 0}},
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
    actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
    next = {{x = 21*gridsize, y = 23*gridsize, facing = 2, location = "overworld", canWork = 1},
            {x = 21*gridsize, y = 15*gridsize, facing = 4, location = "dormitory", canWork = 0}},
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
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 16*gridsize, y = 21*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 16*gridsize, y = 20*gridsize, facing = 4, location = "overworld", canWork = 0}},
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
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 10*gridsize, y = 27*gridsize, facing = 4, location = "overworld", canWork = 0},
              {x = 0, y = 0, facing = 0, location = "offscreen", canWork = 0}},
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
      working = 1,
      canWork = 1,
      timer = {ct = 0, mt = 0, wt = 0}, -- timer for direction changes, etc.
      location = "overworld",
      dialogue = 0,
      name = "Cress", -- 5
      status = "worker",
      animationkey = 21, -- where animations start
      n = 1, --stage in single conversation
      c = 1,
      battlestats = {maxhp = 3, damage = 1,  moves = 1},
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
      next = {{x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0},
              {x = 10*gridsize, y = 9*gridsize, facing = 2, location = "dormitory", canWork = 0}},
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
      speed = 25,
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
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
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
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
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
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
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
      actions = {key = 0, index = 0, x = 0, y = 0, on = 0},
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
actions = {player = {current = 0, max = 100, rate = 10, x = 0, y = 0, key = 0, index = 0}
          }
--battle
battleMode = 0
battleGlobal = {maxmoves = #player.party + 2, movesTaken = 0, turn = 0, phase = 0}

require("scripts/battle")
--object text index for background objects
staticObjects = {overworld = {
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
    playerBed = {{x = 15*gridsize, y = 16*gridsize}}
  }
}

objectInventory = {barrelSmBerries = 0, barrelLgBerries = 0}

itemStats = {plantSmBerries = {max = 60, stackable = 1},
            plantLgBerries = {max = 60, stackable = 1},
            platefull2 = {max = 60, stackable = 0}
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

multiply = love.graphics.newShader( "multiply.glsl" )

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


-- save files
save = {total = 0, current = 0, name = ""}
