

function lockDialogue(tbl)
	for i = 1, #tbl do
		if tbl[i].locked == 1 then
			tbl[i].off = 0
		elseif tbl[i].locked == 0 then
			tbl[i].off = 1
		end
	end
end

-- test to see if player next to object, return object name
function testObject(x, y, tbl)
	if tbl ~= nil then
		local m = (player.act_x / 16) + x
		local n = (player.act_y / 16) + y
		for i = 1, #tbl do
			if m*gridsize == tbl[i].x and n*gridsize == tbl[i].y then
				if tbl[i].off ~= nil then
					if tbl[i].off == 0 then
						return true, tbl[i].name, i
					else
						return false, nil
					end
				end
				print("object name for testObject: " .. tbl[i].name)
				return true, tbl[i].name, i
			end
		end
	else
		return false, nil
	end
end

function testNpcObject(dir, x, y, tbl)
	for i = 1, #tbl do
		local x2 = tbl[i].x
		local y2 = tbl[i].y
		if dir == 1 then
			if x == x2 and y - gridsize == y2 then
				return x2, y2, tbl[i].name
			end
		elseif dir == 2 then
			if x == x2 and y + gridsize == y2 then
				return x2, y2, tbl[i].name
			end
		elseif dir == 3 then
			if y == y2 and x - gridsize == x2 then
				return x2, y2, tbl[i].name
			end
		elseif dir == 4 then
			if y == y2 and x + gridsize == x2 then
				return x2, y2, tbl[i].name
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
				text = "My inventory is full."
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
						startAction(b, 1)
					  BerryHarvestStart(b, c)
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
						startAction(b, 1)
		        BerryHarvestStart(b, c)
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
				startAction(b, 1)
      end
		else
			print("printObjText set dialogueMode to 0")
			dialogueMode = 0
			player.canMove = 1
      wait.triggered = 0
		end
	elseif actionMode == 1 then
		print("actions[1].current " ..  actions[1].current)
		print("actions[1].max " ..  actions[1].max)
		if actions[1].current < actions[1].max then
			BerryHarvestStart(b, c)
			actions[1].current = actions[1].current + actions[1].rate
			print ("action meter: " .. actions[1].current)
      text = objectText[b][2]
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
				movingObjectData[currentLocation][c].name = "plantSm"
        movingObjectData[currentLocation][c].visible = 1
        actions[1].k = 0
			elseif b == "plantLgBerries" then
				addRemoveItem("I got 10 Rose Berries.", "Rose Berries", 10, b, true)
				movingObjectData[currentLocation][c].name = "plantLg"
        movingObjectData[currentLocation][c].visible = 1
        actions[1].k = 0
      elseif b == "barrelSmBerries" then
        BerryBarrel(b, c, "Plum Berries")
        return
      elseif b == "barrelLgBerries" then
        BerryBarrel(b, c, "Rose Berries")
        return
      end
			print("Current = max")
			actions[1].current = 0
			actionMode = 0
		end
	end
end

--test to see if player facing object, retrieve description
function faceObject(char, dir, tbl)
	if dir == 1 then -- up
		local a, b, c = testObject(0, -1, tbl)
		if a and b ~= nil then
      storedIndex[1] = c
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
      storedIndex[1] = c
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
      storedIndex[1] = c
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
      storedIndex[1] = c
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
    actions[1].rate = 10
    actions[1].k = 1
    -- k = key for object animation
  elseif b == "plantLgBerries" then
    actions[1].rate = 15
    actions[1].k = 2
  elseif b == "barrelSmBerries" then
    actions[1].k = 3
    actions[1].current = actions[1].max
  elseif b == "barrelLgBerries" then
    actions[1].k = 4
    actions[1].current = actions[1].max
  end
  movingObjectData[currentLocation][c].visible = 0 -- hide still sprite
  actions[1].x = movingObjectData[currentLocation][c].x
  actions[1].y = movingObjectData[currentLocation][c].y
  actionMode = 1
end

function BerryBarrel(b, c, sub, icon)
  local present, k = checkInventory(sub)
  if present == 1 then
		objectInventory[b] = objectInventory[b] + player.inventory[k].amount
    addRemoveItem("Dropped " .. player.inventory[k].amount .. " " .. sub .. "\nBerries in barrel: " .. objectInventory[b], sub, -player.inventory[k].amount, icon, true)
		actionMode = 0
		actions[1].current = 0
		return
  else
    text = "I don't have any " .. sub .. ".\nBerries in barrel: " .. objectInventory[b]
    wait.triggered = 1
		wait.n = string.len(text)
    movingObjectData[currentLocation][c].visible = 1
    actions[1].current = 0
    actions[1].k = 0
    actionMode = 0
  end
end

function startAction(b, n)
	print("startAction set dialogueMode to 1")
	dialogueMode = 1
	currentspeaker = "player"
	print("n: " .. n)
	if objectText[b][n]~= nil then
		text = objectText[b][n]
		wait.triggered = 1
		wait.n = string.len(text)
	end
end

function exitAction()
	if actionMode == 1 then
		if storedIndex[1] then
			movingObjectData[currentLocation][storedIndex[1]].visible = 1
		end
		actions[1].k = 0
		actions[1].current = 0
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
			addRemoveItem(objectText[i][itemEffects[i].text], item, -1, i, false)
		end
	else
		print("no action possible")
		text = "I can't use that item."
		return false, text
	end
end

itemEffects = {platefull2 = {type = "once", description = "Restores Energy", text = 1, func = energyMod, par = {100}}
							}
