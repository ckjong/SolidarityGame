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
        elseif key == "escape" then
          menu.position[1] = menu.position[1] - 1
          noteMode = 0
        end
      end
    end
  end
end

function addNotes(t)
  if menu.position[1] == 4 and menu.currentTab == "map1" then
    local l = 220 -- character limit
    local i = menu.position[2]
    if menu.position[3] == 2 then
      noteMode = 1
      if string.len(socialMap[i].info.notes) < l then
        socialMap[i].info.notes = socialMap[i].info.notes .. t
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
