function menuEscape()
  menu.position[1] = 1
  menu.position[2] = 1
  menu.currentTab = "inventory"
  player.canMove = 1
  menuView = 0
end

function switchTabs(key)
  for i = 1, menu.tabNum do
    if menu.currentTab == menu.allTabs[i] then
      if key == "right" then
        if i < menu.tabNum then
          i = i + 1
          return menu.allTabs[i]
        else
          i = 1
          return menu.allTabs[i]
        end
      elseif key == "left" then
        if i > 1 then
          i = i - 1
          return menu.allTabs[i]
        else
          i = menu.tabNum
          return menu.allTabs[i]
        end
      end
    end
  end
end

function inventorySelect(key)
	if key == "right" then
		if menu.position[1] == 2 then
			if menu.position[2] < #player.inventory then
				menu.position[2] = menu.position[2] + 1
			end
		end
	elseif key == "left" then
		if menu.position[1] == 2 then
			if menu.position[2] > 1 then
				menu.position[2] = menu.position[2] - 1
			end
		end
	-- elseif key == "up" then
	-- 	if menu.position[1] == 3 then
	-- 		if menu.position[3] > 1 then
	-- 			menu.position[3] = menu.position[3] - 1
	-- 		end
	-- 	end
	-- elseif key == "down" then
	-- 	if menu.position[1] == 3 then
	-- 		if menu.position[3] < 2 then
	-- 			menu.position[3] = menu.position[3] + 1
	-- 		end
	-- 	end
	end
end

--move betweeen levels of the menu
function menuHierarchy(key)
	if key == "x" then
		if menu.position[1] > 1 then
			if menu.position[1] == 3 then
				menu.position[3] = 1
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
		else
			menu.total = 1
		end
		if menu.position[1] < menu.total then
			menu.position[1] = menu.position[1] + 1
			print("added to menu position[1]: " .. menu.position[1])
			return
		end
		itemMenu()
	end
end

function itemMenu()
	local i = menu.position[2]
	if menu.position[1] == 3 and menu.currentTab == "inventory" then
		if menu.position[3] == 1 then
			print("menu position[1]: " .. menu.position[1])
			useItem(player.inventory[i].icon, player.inventory[i].item)
			menu.position[1] = 2
			menu.position[3] = 1
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
