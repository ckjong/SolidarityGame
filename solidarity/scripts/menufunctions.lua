local bitser = require("libraries/bitser/bitser")

function openMenu(tab)
  if dialogueMode == 0 and titleScreen == 0 then
    if menuView == 0 then
      if tab ~= nil then
        menu.currentTab = tab
      end
      player.canMove = 0
      menuView = 1
    else
      menuEscape()
    end
  end
end

function menuEscape()
  print("escape menu")
  menu.position = {1, 1, 1, 1}
  menu.grid = {1,1}
  menu.currentTab = "inventory"
  player.canMove = 1
  menuView = 0
  print("menu.grid: " .. menu.grid[1] .. menu.grid[2])
end

function switchTabs(key)
  for i = 1, menu.tabNum do
    if menu.currentTab == menu.allTabs[i] then
      if key == "right" then
        if i < menu.tabNum then
          i = i + 1
          menu.grid = {1, 1}
          menu.position[2] = 1
          return menu.allTabs[i]
        else
          i = 1
          return menu.allTabs[i]
        end
      elseif key == "left" then
        if i > 1 then
          i = i - 1
          menu.grid = {1, 1}
          menu.position[2] = 1
          return menu.allTabs[i]
        else
          i = menu.tabNum
          return menu.allTabs[i]
        end
      end
    end
  end
end

-- function changeMenuPosition(n1, n2, lim, amount, tbl)
--   if menu[tbl][n1] == n2 then
--     if amount > 0 then
--       if menu[tbl][n2] < lim then
--         menu[tbl][n2] = menu[tbl][n2] + amount
--       end
--     else
--       if menu[tbl][n2] > lim then
--         menu[tbl][n2] = menu[tbl][n2] + amount
--       end
--     end
--   end
-- end

function inventorySelect(key, num, tab)
  print("menu.position[1] " .. menu.position[1])
	if key == "right" then
    if menu.position[1] == 2 then
  		if menu.position[2] < num then
  			menu.position[2] = menu.position[2] + 1
      end
      if tab == "map1" then
        if menu.grid[1] < menu.tabData[tab].c then
          menu.grid[1] = menu.grid[1] + 1
        else
          if menu.grid[2] < menu.tabData[tab].r then
            menu.grid[2] = menu.grid[2] + 1
            menu.grid[1] = 1
          end
        end
      end
    end
	elseif key == "left" then
    if menu.position[1] == 2 then
  		if menu.position[2] > 1 then
  			menu.position[2] = menu.position[2] - 1
      end
      if tab == "map1" then
        if menu.grid[1] > 1 then
          menu.grid[1] = menu.grid[1] - 1
        else
          if menu.grid[2] > 1 then
            menu.grid[2] = menu.grid[2] - 1
            menu.grid[1] = menu.tabData[tab].c
          end
        end
      end
		end
  elseif key == "up" then
    if tab == "map1" then
      if menu.position[1] == 2 then
        if menu.grid[2] > 1 then
          menu.grid[2] = menu.grid[2] - 1
          menu.position[2] = menu.position[2] - menu.tabData[tab].c
        end
      elseif menu.position[1] == 3 then
        if menu.position[3] > 1 then
          menu.position[3] = menu.position[3] - 1
        end
      elseif menu.position[1] == 4 then
        if menu.position[4] > 1 then
          menu.position[4] = menu.position[4] - 1
        end
      end
    end
  elseif key == "down" then
    if tab == "map1" then
      if menu.position[1] == 2 then
        if menu.grid[2] < menu.tabData[tab].r then
          if menu.position[2] + menu.tabData[tab].c <= num then
            menu.grid[2] = menu.grid[2] + 1
            menu.position[2] = menu.position[2] + menu.tabData[tab].c
          end
        end
      elseif menu.position[1] == 3 then
        if menu.position[3] < 2 then
          menu.position[3] = menu.position[3] + 1
        end
      elseif menu.position[1] == 4 then
        if menu.position[4] < 6 then
          menu.position[4] = menu.position[4] + 1
        end
      end
    end
	end
  print("grid " .. menu.grid[1] .. menu.grid[2])
end

--move betweeen levels of the menu
function menuHierarchy(key)
	if key == "x" then
		if menu.position[1] > 1 then
			if menu.position[1] == 3 then
				menu.position[3] = 1
      elseif 	menu.position[1] == 4 then
        menu.position[4] = 1
			end
			menu.position[1] = menu.position[1] - 1
		else
			menuEscape()
		end
	elseif key == "z" then
		if menu.currentTab == "inventory" then
			if #player.inventory < 1 then
				menu.total = 2
			else
        local i = menu.position[2]
        local b = player.inventory[i].icon
        if itemStats[b].use ~= nil then
          print("use not nil")
				  menu.total = 3
        else
          menu.total = 2
        end
			end
    elseif menu.currentTab == "map1" then
      if #socialMap >= 1 then
        menu.total = 4
      else
        menu.total = 1
      end
		else
			menu.total = 1
		end
		if menu.position[1] < menu.total then
			menu.position[1] = menu.position[1] + 1
			print("added to menu position[1]: " .. menu.position[1])
			return
		end
    changeSupport()
		itemMenu()
	end
end

function changeSupport()
  if menu.position[1] == 4 and menu.currentTab == "map1" then
    local i = menu.position[2]
    if menu.position[3] == 1 then
      if menu.position[4] == 1 then
        socialMap[i].mapping.lvl = "?"
      elseif menu.position[4] > 1 then
        socialMap[i].mapping.lvl = menu.position[4] - 1
      end
      menu.position[1] = menu.position[1] - 1
      menu.position[4] = 1
    end
  end
end

function removeNotes(key)
  if menu.position[1] == 4 and menu.currentTab == "map1" then
    -- local l = 220 -- character limit
    local i = menu.position[2]
    if menu.position[3] == 2 then
      if noteMode == 1 then
        if key == "backspace" then
          print("backspace")
          socialMap[i].info.notes = string.sub(socialMap[i].info.notes, 1,-2)
        -- elseif key == "space" then
        --   if string.len(socialMap[i].info.notes) < l then
        --     socialMap[i].info.notes = socialMap[i].info.notes .. " "
        --   end
        elseif key == "return" then
          menu.position[1] = menu.position[1] - 1
          noteMode = 0
        end
      end
    end
  end
end

function addNotes(t)
  if menu.position[1] == 4 and menu.currentTab == "map1" then
    local i = menu.position[2]
    if menu.position[3] == 2 then
      if noteMode == 0 then
        noteMode = 1
        return
      else
        socialMap[i].info.notes = socialMap[i].info.notes .. t
        local width, wrappedtext = font:getWrap(socialMap[i].info.notes, 180)
        print("lines: " .. #wrappedtext)
        local l = #wrappedtext
        if l >= 8 then
          socialMap[i].info.notes = socialMap[i].info.notes:sub(1, -2)
        end
      end
    end
  end
end

function itemMenu()
	local i = menu.position[2]
	if menu.position[1] == 3 and menu.currentTab == "inventory" then
		if menu.position[3] == 1 then
      sfx.textSelect:play()
			useItem(player.inventory[i].icon, player.inventory[i].item)
			if player.inventory[i] == nil then
				menu.position[2] = 1
			end
		-- elseif menu.position[3] == 2 then
    --   if itemStats[player.inventory[i].icon].dropNum ~= nil then
  	-- 		addRemoveItem("Dropped " .. player.inventory[i].item, player.inventory[i].item, -itemStats[player.inventory[i].icon].dropNum, player.inventory[i].icon, false)
  	-- 		print("removing item done")
    --   else
    --     itemText = "You can't drop that."
    --     print("can't drop item")
    --   end
		-- 	menu.position[1] = 2
		-- 	menu.position[3] = 1
		-- 	if player.inventory[i] == nil then
		-- 		menu.position[2] = 1
		-- 	end
		end
	end
end

function setTitleScreen(n)
  if n == 1 then
    player.canMove = 0
    titleScreen = 1
    print("title screen on")
  elseif n == 0 then
    player.canMove = 1
    titleScreen = 0
    sfx.textSelect:play()
    print("title screen off")
  end
end

function saveGame(name, data)
  f = assert(io.open(name, "w"))
  f:write(data)
  f:close(data)
end

function saveDialogueLogic()
  local tbl = {}
  for i = 0, #NPCdialogue do
    tbl[i] = {}
    for k, v in pairs(NPCdialogue[i]) do
      tbl[i][k] = {}
      for j = 1, #NPCdialogue[i][k] do
        tbl[i][k][j] = {}
        tbl[i][k][j].logic = {}
        tbl[i][k][j].logic.next = NPCdialogue[i][k][j].logic.next
        tbl[i][k][j].logic.cond = NPCdialogue[i][k][j].logic.cond
        if NPCdialogue[i][k][j].logic.spoken ~= nil then
          tbl[i][k][j].logic.spoken = NPCdialogue[i][k][j].logic.spoken
        end
      end
    end
  end
  return tbl
end

function loadDialogueLogic(tbl)
  for i = 0, #tbl do
    for k, v in pairs(tbl[i]) do
      for j = 1, #tbl[i][k] do
        if NPCdialogue[i][k][j] ~= nil then
          NPCdialogue[i][k][j].logic.next = tbl[i][k][j].logic.next
          NPCdialogue[i][k][j].logic.cond = tbl[i][k][j].logic.cond
          if NPCdialogue[i][k][j].logic.spoken ~= nil then
            NPCdialogue[i][k][j].logic.spoken = tbl[i][k][j].logic.spoken
          end
        end
      end
    end
  end
end


function saveGameData()
  local tbl = {}
  tbl.gameStage = gameStage
  tbl.workStage = workStage
  tbl.dialogueStage = dialogueStage
  tbl.tempBlocks = {}
  for k, v in pairs(tempBlocks) do
    tbl.tempBlocks[k] = {}
    for i = 1, #tempBlocks[k] do
      tbl.tempBlocks[k][i] = {on = tempBlocks[k][i].on}
    end
  end
  tbl.locationTriggers = {}
  for k, v in pairs(locationTriggers) do
    tbl.locationTriggers[k] = {}
    for i = 1, #locationTriggers[k] do
      tbl.locationTriggers[k][i] = {locked = locationTriggers[k][i].locked}
    end
  end
  tbl.currentLocation = currentLocation
  tbl.time = time
  tbl.day = day
  tbl.uiSwitches = {bedArrow = uiSwitches.bedArrow}
  tbl.menu = {tabNum = menu.tabNum}
  tbl.objectInventory = objectInventory
  tbl.player = {}
  for k, v in pairs(player) do
    tbl.player[k] = v
  end
  tbl.npcs = {}
  for k, v in pairs(npcs) do
    tbl.npcs[k] = v
  end
  tbl.socialMap = socialMap
  tbl.movingObjectData = {}
  tbl.movingObjectData.overworld = movingObjectData.overworld
  -- tbl.movingObjectData = {}
  -- for k, v in pairs(movingObjectData) do
  --   tbl.movingObjectData[k] = {}
  --   for l, u in pairs(movingObjectData[k]) do
  --     tbl.movingObjectData[k][l] = {}
  --     for i = 1, #movingObjectData[k][l] do
  --       tbl.movingObjectData[k][l][i] = {
  --         used = movingObjectData[k][l][i].used,
  --         picked = movingObjectData[k][l][i].picked,
  --         trigger = movingObjectData[k][l][i].trigger}
  --     end
  --   end
  -- end
  tbl.nonInteractiveObjects = nonInteractiveObjects
  tbl.cutsceneControl = cutsceneControl
  tbl.cutsceneList = {}
  for i = 1, #cutsceneList do
    tbl.cutsceneList[i] = {triggered = cutsceneList[i].triggered}
  end
  return tbl
end

function loadGameData(tbl)
  gameStage = tbl.gameStage
  workStage = tbl.workStage
  dialogueStage = tbl.dialogueStage
  for k, v in pairs(tbl.tempBlocks) do
    for i = 1, #tbl.tempBlocks[k] do
      tempBlocks[k][i].on = tbl.tempBlocks[k][i].on
    end
  end
  for k, v in pairs(tbl.locationTriggers) do
    for i = 1, #tbl.locationTriggers[k] do
      locationTriggers[k][i].locked = tbl.locationTriggers[k][i].locked
    end
  end
  currentLocation = tbl.currentLocation
  time = tbl.time
  day = tbl.day
  uiSwitches.bedArrow = tbl.uiSwitches.bedArrow
  menu.tabNum = tbl.menu.tabNum
  objectInventory = tbl.objectInventory
  for k, v in pairs(tbl.player) do
    player[k] = v
  end
  for i, u in pairs(tbl.npcs) do
    npcs[i] = u
  end
  socialMap = tbl.socialMap
  cutsceneControl = tbl.cutsceneControl
  movingObjectData = tbl.movingObjectData
  movingObjectAnims = createAnimations(movingObjectData.overworld, movingObjectAnimParams)
  nonInteractiveObjects = tbl.nonInteractiveObjects
  for i = 1, #cutsceneList do
    cutsceneList[i].triggered = tbl.cutsceneList[i].triggered
    cutsceneList[i].path = {}
    cutsceneList[i].noden = 1
  end
  -- for k, v in pairs(tbl.movingObjectData) do
  --   for l, u in pairs(tbl.movingObjectData[k]) do
  --     for i = 1, #tbl.movingObjectData[k][l] do
  --       if movingObjectData[k][l][i] ~= nil then
  --         movingObjectData[k][l][i].used = tbl.movingObjectData[k][l][i].used
  --         movingObjectData[k][l][i].picked = tbl.movingObjectData[k][l][i].picked
  --         movingObjectData[k][l][i].trigger = tbl.movingObjectData[k][l][i].trigger
  --     end
  --   end
  -- end
end

function saveMapData()
  local tbl = {}
  for k, v in pairs(mapdata) do
    tbl[k] = v
  end
  return tbl
end

function loadMapData(tbl)
  for k, v in pairs(tbl) do
    if mapdata[k] ~= nil then
      mapdata[k] = v
    end
  end
  locationMaps(currentLocation)
  changeBackground(currentLocation)
end

function combineSaveTables()
  local tbl = {}
  tbl.gamedata = saveGameData()
  tbl.mapdata = saveMapData()
  tbl.dialogue = saveDialogueLogic()
  return tbl
end

function createSaveFile(filename)
  local tbl = combineSaveTables()
  if love.filesystem.exists(filename) == true then
    love.filesystem.remove(filename)
  end
  SaveGame = love.filesystem.newFile(filename, "w")
  --when saving a game
  local binary_data = bitser.dumps(tbl)
  success, message = love.filesystem.write(filename, binary_data)
  if success == true then
    print("game saved")
  else
    print(message)
  end
end

function loadSaveFile(filename)
  local tbl = {}
  local exists = love.filesystem.exists(filename)
  if exists == true then
    local data = love.filesystem.newFileData(filename)
    tbl = bitser.loadData(data:getPointer(), data:getSize())
    return tbl
  else
    print("file does not exist")
  end
end

function unpackSaveTables(filename)
  local tbl = loadSaveFile(filename)
  if tbl.gamedata ~= nil then
    loadGameData(tbl.gamedata)
  else
    print("gamedata table not valid")
  end
  if tbl.dialogue ~= nil then
    loadDialogueLogic(tbl.dialogue)
  else
    print("dialogue table not valid")
  end
  if tbl.mapdata ~= nil then
    loadMapData(tbl.mapdata)
  else
    print("mapdata table not valid")
  end
end

function compileSaveData(name)
  local dir = "maps"
  local files = love.filesystem.enumerate(dir)
  local path = {}
  for k, file in ipairs(files) do
    path[k] = tostring(dir .. "/" .. file)
  end
  local data = {love.filesystem.newFileData("scripts/dialogue")}
  for i = 1, #path do
    table.insert(data, path[i])
  end
  for i = 1, #data do
    success, errormsg = love.filesystem.append(name, data[i])
  end
end
