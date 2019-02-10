

function lockDialogue(tbl)
	for i = 1, #tbl do
		if tbl[i].locked == 1 then
			objectText[tbl[i].name].logic.off = false
		elseif tbl[i].locked == 0 then
			print("object i turned off " .. i)
			objectText[tbl[i].name].logic.off = true
		end
	end
end

-- test to see if player next to object, return object name
function testObject(x, y, tbl)
	if tbl ~= nil then
		local m = (player.act_x / gridsize) + x
		local n = (player.act_y / gridsize) + y
		for k, v in pairs(tbl) do
			for i = 1, #tbl[k] do
				if m*gridsize == tbl[k][i].x and n*gridsize == tbl[k][i].y then
					if tbl[k][i].off ~= nil then
						if tbl[k][i].off == 0 then
							return true, k, i
						else
							return false, nil
						end
					end
					print("object name for testObject: " .. k)
					return true, k, i
				end
			end
		end
	else
		return false, nil
	end
end

function updateActionsTable(tbl, x2, y2, k, i, n)
	actions.npcs[n].x = x2
	actions.npcs[n].y = y2
	actions.npcs[n].key = k
	actions.npcs[n].index = i
	tbl[k][i].running = 1
	tbl[k][i].used = 1
end

function testNpcObject(dir, x, y, tbl, npc)
	if tbl ~= nil then
		for k, v in pairs(tbl) do
			for i = 1, #tbl[k] do
				local x2 = tbl[k][i].x
				local y2 = tbl[k][i].y
				if dir == 1 then
					if x == x2 and y - gridsize == y2 then
						if tbl[k][i].running == 0 then
							updateActionsTable(tbl, x2, y2, k, i, npc)
						else
							return
						end
					end
				elseif dir == 2 then
					if x == x2 and y + gridsize == y2 then
						if tbl[k][i].running == 0 then
							updateActionsTable(tbl, x2, y2, k, i, npc)
						else
							return
						end
					end
				elseif dir == 3 then
					if y == y2 and x - gridsize == x2 then
						if tbl[k][i].running == 0 then
							updateActionsTable(tbl, x2, y2, k, i, npc)
						else
							return
						end
					end
				elseif dir == 4 then
					if y == y2 and x + gridsize == x2 then
						if tbl[k][i].running == 0 then
							updateActionsTable(tbl, x2, y2, k, i, npc)
						else
							return
						end
					end
				end
			end
		end
	end
end

function inventoryFull(m)
	if #player.inventory >= m then
		return true
	else
		return false
	end
	-- local total = 0
	-- if #player.inventory > 0 then
	-- 	for k = 1, #player.inventory do
	-- 		total = total + player.inventory[k].amount
	-- 		if total >= m then
	-- 			return true
	-- 		end
	-- 	end
	-- 	return false
	-- else
	-- 	return false
	-- end
end

function checkInventory(i) -- i = player.inventory[k].item
  if #player.inventory > 0 then
    for k = 1, #player.inventory do
      if player.inventory[k].item == i then
        -- check if item already in the inventory
        return 1, k
      end
    end
    return 0
  else
    print("inventory empty")
    return 0
  end
end


function addRemoveItem(txt, i, a, b, w) -- text to display, item, amount, icon name, wait
	if w == true then
		wait.triggered = 1
	  wait.n = string.len(txt)
	end
  text = txt
  local present, k = checkInventory(i)
  -- if present == 1 then
		-- if itemStats[b].unique == 0 then
		-- 	--change amount of existing item
	  --   player.inventory[k].amount = player.inventory[k].amount + a
	  --   if player.inventory[k].amount <= 0 then
	  --     --all items removed
	  --     player.inventory[k] = nil
	  --     table.remove(player.inventory, k)
	  --   end
		-- else
		if a > 0 then
			if inventoryFull (player.maxInventory) == false then
				table.insert(player.inventory, {item = i, amount = a, icon = b})
			else
				text = "I can't carry any more."
			end
		else
			player.inventory[k] = nil
			table.remove(player.inventory, k)
		end
	-- 	end
  -- elseif present == 0 then
  --   if a > 0 then
  --     -- if item not there, create new entry
  --     table.insert(player.inventory, {item = i, amount = a, icon = b})
  --   end
  -- end
end

--pass object description to text, change dialogue mode
function printObjText(b, c)
	if actionMode == 0 then
		if dialogueMode == 0 then
      if b == "plantSmBerries" then
				if inventoryFull (player.maxInventory) == false then -- check if space in inventory
					if freeze.action == 0 then -- check if player has energy
						if movingObjectData[currentLocation][b][c].used == 0 then
							startAction(b, 1)
						  BerryHarvestStart(b, c)
						end
					elseif freeze.action == 1 then
						startAction(b, 3)
					end
				else
					if freeze.action == 1 then
						startAction(b, 3)
					else
						startAction(b, 4)
					end
				end
      elseif b == "plantLgBerries" then
				if inventoryFull (player.maxInventory) == false then
					if freeze.action == 0 then
						if movingObjectData[currentLocation][b][c].used == 0 then
							startAction(b, 1)
			        BerryHarvestStart(b, c)
						end
					elseif freeze.action == 1 then
						startAction(b, 3)
					end
				else
					if freeze.action == 1 then
						startAction(b, 3)
					else
						startAction(b, 4)
					end
				end
			elseif b == "barrelSmBerries" then
				startAction(b, 1)
        BerryHarvestStart(b, c)
        BerryBarrel(b, c, "Plum Berries", "plantSmBerries")
        return
      elseif b == "barrelLgBerries" then
				startAction(b, 1)
        BerryHarvestStart(b, c)
        BerryBarrel(b, c, "Rose Berries", "plantLgBerries")
        return
			else
				print("Not berries or barrel obj: " .. b)
				startAction(b, 1)
      end
		else
			print("printObjText set dialogueMode to 0")
			dialogueMode = 0
			player.canMove = 1
      wait.triggered = 0
		end
	elseif actionMode == 1 then
		print("actions.player.current " ..  actions.player.current)
		print("actions.player.max " ..  actions.player.max)
		if actions.player.current < actions.player.max then
			BerryHarvestStart(b, c)
			actions.player.current = actions.player.current + actions.player.rate
			print ("action meter: " .. actions.player.current)
      text = objectText[b].text[2]
			if player.energy > 0 then
				player.energy = player.energy - 1
			end
			if player.energy <= 0 then
				exitAction()
			end
			print("player energy: " .. player.energy)
		else
			if b == "plantSmBerries" then
				addRemoveItem("I got 10 Plum Berries.", "Plum Berries", 10, b, true)
				movingObjectData[currentLocation][b][c]["anim"]["spriteSheet"] = animsheet3
				movingObjectData[currentLocation][b][c]["anim"]["quads"] = {movingObjectQuads.plantSm}
				table.insert(movingObjectData[currentLocation].plantSm, movingObjectData[currentLocation][b][c])
				table.remove(movingObjectData[currentLocation][b], c)
				-- movingObjectData[currentLocation][b][c].used = 1
				-- movingObjectData[currentLocation][b][c].visible = 0

			elseif b == "plantLgBerries" then
				addRemoveItem("I got 10 Rose Berries.", "Rose Berries", 10, b, true)
				movingObjectData[currentLocation][b][c]["anim"]["spriteSheet"] = animsheet3
				movingObjectData[currentLocation][b][c]["anim"]["quads"] = {movingObjectQuads.plantLg}
				table.insert(movingObjectData[currentLocation].plantLg, movingObjectData[currentLocation][b][c])
				table.remove(movingObjectData[currentLocation][b], c)
				-- movingObjectData[currentLocation][b][c].used = 1

      elseif b == "barrelSmBerries" then
        BerryBarrel(b, c, "Plum Berries")
        return
      elseif b == "barrelLgBerries" then
        BerryBarrel(b, c, "Rose Berries")
        return
      end
			print("Current = max")
			actions.player.current = 0
			actionMode = 0
		end
	end
end

--test to see if player facing object, retrieve description
function faceObject(char, dir, tbl)
	print("faceobject triggered " .. tostring(tbl))
	if dir == 1 then -- up
		local a, b, c = testObject(0, -1, tbl)
		if a and b ~= nil then
      actions.player.index = c
			print("dir 1")
			if char == player then
				printObjText(b, c)
				return
			else
				return a, b, c
			end
		end
	elseif dir == 2 then -- down
		local a, b, c = testObject(0, 1, tbl)
		if a and b ~= nil then
      actions.player.index = c
			print("dir 2")
			if char == player then
				printObjText(b, c)
				return
			else
				return a, b, c
			end
		end
	elseif dir == 3 then -- left
		local a, b, c = testObject(-1, 0, tbl)
		if a and b ~= nil then
      actions.player.index = c
			print("dir 3")
			if char == player then
				printObjText(b, c)
				return
			else
				return a, b, c
			end
		end
	elseif dir == 4 then -- right
		local a, b, c = testObject(1, 0, tbl)
		if a and b ~= nil then
      actions.player.index = c
			print("dir 4")
			if char == player then
				printObjText(b, c)
				return
			else
				return a, b, c
			end
		end
	end
end

-- berry harvest
function BerryHarvestStart(b, c)
  if b == "plantSmBerries" then
    actions.player.rate = 10
    actions.player.key = b
		print("actions.player.key " .. actions.player.key)
		player.animations.act[player.facing].running = 1
		movingObjectData[currentLocation][b][c].running = 1
    -- k = key for object animation
  elseif b == "plantLgBerries" then
    actions.player.rate = 15
    actions.player.key = b
		print("actions.player.key " .. actions.player.key)
		player.animations.act[player.facing].running = 1
		movingObjectData[currentLocation][b][c].running = 1
  elseif b == "barrelSmBerries" then
    actions.player.key = b
		print(actions.player.key)
    actions.player.current = actions.player.max
		movingObjectData[currentLocation][b][c].running = 1
  elseif b == "barrelLgBerries" then
    actions.player.key = b
		print(actions.player.key)
    actions.player.current = actions.player.max
		movingObjectData[currentLocation][b][c].running = 1
  end
  -- movingObjectData[currentLocation][actions.player.key][actions.player.index].visible = 0 -- hide still sprite
  actions.player.x = movingObjectData[currentLocation][actions.player.key][actions.player.index].x
  actions.player.y = movingObjectData[currentLocation][actions.player.key][actions.player.index].y
  actionMode = 1
end

function BerryBarrel(b, c, sub, icon)
  local present, k = checkInventory(sub)
  if present == 1 then
		objectInventory[b] = objectInventory[b] + player.inventory[k].amount
    addRemoveItem("Dropped " .. player.inventory[k].amount .. " " .. sub .. "\nBerries in barrel: " .. objectInventory[b], sub, -player.inventory[k].amount, icon, true)
		actionMode = 0
		actions.player.current = 0
		return
  else
    text = "I don't have any " .. sub .. ".\nBerries in barrel: " .. objectInventory[b]
    wait.triggered = 1
		wait.n = string.len(text)
    actions.player.current = 0
    actions.player.key = 0
		actions.player.index = 0
    actionMode = 0
  end
end

function startAction(b, n)
	if objectText[b].logic.off == false then
		print("startAction set dialogueMode to 1")
		dialogueMode = 1
		currentspeaker = "player"
		print("n: " .. n)
		if objectText[b].text[n]~= nil then
			print("objectText not nil")
			text = objectText[b].text[n]
			wait.triggered = 1
			wait.n = string.len(text)
		end
	end
end

function exitAction()
	if actionMode == 1 then
		actions.player.key = 0
		actions.player.current = 0
		player.canMove = 1
		actionMode = 0
		print("exitAction set dialogueMode to 0")
		dialogueMode = 0
		wait.triggered = 0
		keyInput = 1
	end
end

function freezeControl()
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
end

function energyMod(a)
	print("energized")
	player.energy = player.energy + a
	if player.energy > 100 then
		player.energy = 100
	elseif player.energy < 0 then
		player.energy = 0
	end
end

function afterItemUse()
	print("used Item, dialogueMode set to 0")
	player.canMove = 1
	dialogueMode = 0
	actionMode = 0
	usedItem = 0
	return
end


function useItem(i, item)
	local text = ""
	if itemEffects[i] ~= nil then
		print("can do action")
		print(itemEffects[i].text)
		itemEffects[i].func(unpack(itemEffects[i].par))
		menuView = 0
		usedItem = 1
		startAction(i, itemEffects[i].text)
		if itemEffects[i].type == "once" then
			print("remove used item")
			addRemoveItem(objectText[i].text[itemEffects[i].text], item, -1, i, false)
		end
	else
		print("no action possible")
		text = "I can't use that item."
		return false, text
	end
end

itemEffects = {platefull2 = {type = "once", description = "Restores Energy", text = 1, func = energyMod, par = {100}}
							}
