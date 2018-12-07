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
	elseif key == "up" then
		if menu.position[1] == 3 then
			if menu.position[3] > 1 then
				menu.position[3] = menu.position[3] - 1
			end
		end
	elseif key == "down" then
		if menu.position[1] == 3 then
			if menu.position[3] < 2 then
				menu.position[3] = menu.position[3] + 1
			end
		end
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
			menuView = 0
			player.canMove = 1
			menu.position[2] = 1
		end
	elseif key == "z" then
		if menu.currentTab == "inventory" then
			if #player.inventory < 1 then
				menu.total = 2
			else
				menu.total = 3
				print("menu total: " .. menu.total)
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
			useItem(player.inventory[menu.position[2]].icon)
			menu.position[1] = 2
			menu.position[3] = 1
			if player.inventory[i] == nil then
				menu.position[2] = 1
			end
		elseif menu.position[3] == 2 then
			addRemoveItem("Dropped " .. player.inventory[i].item, player.inventory[i].item, -1, player.inventory[i].icon, false)
			print("removing item done")
			menu.position[1] = 2
			menu.position[3] = 1
			if player.inventory[i] == nil then
				menu.position[2] = 1
			end
		end
	end
end
