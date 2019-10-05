

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

function updateActionsTable(tbl, k, i, n)
	if npcs[n].working == 1 then
		tbl[k][i].running = 1
		tbl[k][i].used = 1
	-- else
	-- 	if tbl[k][i].running == 1 then
	-- 		tbl[k][i].running = 0
	-- 		npcs[n].timer.ct = 0
	-- 	end
	end
end

function testNpcObject(dir, x, y, tbl, npc, check)
	if tbl ~= nil then
		for k, v in pairs(tbl) do
			for i = 1, #tbl[k] do
				local x2 = tbl[k][i].x
				local y2 = tbl[k][i].y
				if dir == 1 then
					if x == x2 and y - gridsize == y2 then
						if check == true then
							if tbl[k][i].running == 0 then
								updateActionsTable(tbl, k, i, npc)
							end
						else
							updateActionsTable(tbl, k, i, npc)
						end
					end
				elseif dir == 2 then
					if x == x2 and y + gridsize == y2 then
						if check == true then
							if tbl[k][i].running == 0 then
								updateActionsTable(tbl, k, i, npc)
							end
						else
							updateActionsTable(tbl, k, i, npc)
						end
					end
				elseif dir == 3 then
					if y == y2 and x - gridsize == x2 then
						if check == true then
							if tbl[k][i].running == 0 then
								updateActionsTable(tbl, k, i, npc)
							end
						else
							updateActionsTable(tbl, k, i, npc)
						end
					end
				elseif dir == 4 then
					if y == y2 and x + gridsize == x2 then
						if check == true then
							if tbl[k][i].running == 0 then
								updateActionsTable(tbl, k, i, npc)
							end
						else
							updateActionsTable(tbl, k, i, npc)
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
end

function checkInventory(b) -- b= icon
  if #player.inventory > 0 then
    for k = 1, #player.inventory do
      if player.inventory[k].icon == b then
        -- check if item already in the inventory
        return true, k
      end
    end
    return false
  else
    return false
  end
end

function countTotal(i)
	local total = 0
	if #player.inventory > 0 then
    for k = 1, #player.inventory do
      if player.inventory[k].item == i then
				total = total + player.inventory[k].amount
			end
		end
		return total
	end
end


function addRemoveItem(txt, i, a, b, w) -- text to display, item, amount, icon name, wait
	if w == true then
		wait.triggered = 1
	  wait.n = string.len(txt)
	end
  text = txt
  local present, k = checkInventory(b)
	local total = countTotal(i)
		if a > 0 then
			if inventoryFull (player.maxInventory) == false then
				if itemStats[b].stackable == 1 then
					print(b.." is stackable")
					if present then
						print("item present")
						if player.inventory[k] ~= nil then
							player.inventory[k].amount = player.inventory[k].amount + a
						end
					else
						print("create new stack")
						table.insert(player.inventory, {item = i, amount = a, icon = b})
					end
					-- table.insert(player.inventory, {item = i, amount = a, icon = b})
				else
					for j = 1, a do
						if inventoryFull (player.maxInventory) == false then
							print(b.." not stackable")
							table.insert(player.inventory, {item = i, amount = 1, icon = b})
						end
					end
				end
			else
				text = "I can't carry any more."
			end
		else
			if player.inventory[k] ~= nil then
				if math.abs(a) >= player.inventory[k].amount then
					print("amount " .. a .. "remove all item " .. i)
					table.remove(player.inventory, k)
					-- local div = math.floor(math.abs(a) / player.inventory[k].amount)
					-- while div > 0 do
					-- 	local p, j = checkInventory(b)
					-- 	if p then
					-- 		print("item present")
					-- 		if player.inventory[j] ~= nil then
					-- 			table.remove(player.inventory, j)
					-- 		end
					-- 	end
					-- 	div = div - 1
					-- end
				else
					print("amount " .. a .. "remove some " .. i)
					player.inventory[k].amount = player.inventory[k].amount + a
				end
			end
		end
	-- 	end
  -- elseif present == 0 then
  --   if a > 0 then
  --     -- if item not there, create new entry
  --     table.insert(player.inventory, {item = i, amount = a, icon = b})
  --   end
  -- end
end

function energyMod(a)
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


function useItem(i, item) -- i = icon
	local text = ""
	if itemEffects[i] ~= nil then
		itemEffects[i].func(unpack(itemEffects[i].par))
		menuEscape()
		usedItem = 1
		startAction(i, itemEffects[i].text)
		if itemEffects[i].type == "once" then
			print("remove used item" .. i)
			addRemoveItem(objectText[i].text[itemEffects[i].text], item, -1, i, false)
		end
	else
		print("no action possible")
		text = "I can't use that item."
		return false, text
	end
end

function charGivesObject(a, b, c, d, e)
	print("character gives object")
	currentspeaker = "player"
	addRemoveItem(a, b, c, d, e)
	return
end

-- berry harvest
function BerryHarvestStart(b, c)
	wait.triggered = 1
	wait.current = .4
  if b == "plantSmBerries" then
		if movingObjectData[currentLocation][b][c].picked < 3 then
			movingObjectData[currentLocation][b][c].picked = movingObjectData[currentLocation][b][c].picked + 1
			movingObjectData[currentLocation][b][c].trigger = 1
		else
			movingObjectData[currentLocation][b][c].trigger = 3
		end
		if player.energy > 0 then
			player.energy = player.energy - 1
		end
		sfx.berryPickup:play()
		player.animations.act[player.facing].running = 1
		movingObjectData[currentLocation][b][c].running = 1

    -- k = key for object animation
  elseif b == "plantLgBerries" then
		if movingObjectData[currentLocation][b][c].picked < 5 then
			movingObjectData[currentLocation][b][c].picked = movingObjectData[currentLocation][b][c].picked + 1
			movingObjectData[currentLocation][b][c].trigger = 2
		else
			movingObjectData[currentLocation][b][c].trigger = 4
		end
		if player.energy > 0 then
			player.energy = player.energy - 1
		end
		sfx.berryPickup2:play()
		player.animations.act[player.facing].running = 1
		movingObjectData[currentLocation][b][c].running = 1
  end
  actionMode = 1
end

function setBubble(b, c)
	bubble.on = 1
	bubble.obj = b
	if b == "barrelSmBerries" or b == "barrelLgBerries" then
		bubble.static = 1
		bubble.timer = 1.2
		bubble.type = 1
		bubble.x, bubble.y = movingObjectData[currentLocation][b][c].x, movingObjectData[currentLocation][b][c].y - 16
	else
		bubble.static = 0
		bubble.timer = 1
		if player.facing == 1 then
			bubble.type = 4
			bubble.x, bubble.y = player.act_x, player.act_y + 17
		else
			bubble.type = 1
			bubble.x, bubble.y = player.act_x, player.act_y - 17
		end
	end
end

function BerryBarrel(b, c, sub, icon)
  local present, k = checkInventory(icon)
  if present == true then
		local total = countTotal(sub)
		player.animations.act[player.facing].running = 1
		movingObjectData[currentLocation][b][c].running = 1
		objectInventory[b] = objectInventory[b] + total
		setBubble(b, c)
		sfx.berryDrop:play()
    addRemoveItem("Dropped " .. total .. " " .. sub .. ".", sub, -total, icon, true)
		actionMode = 0
		return
  else
    text = "I don't have any " .. sub .. "."
		setBubble(b, c)
    wait.triggered = 1
		wait.n = string.len(text)
    actionMode = 0
  end
end

function startAction(b, n)
	if objectText[b].logic.off == false then
		print("startAction set dialogueMode to 1")
		dialogueMode = 1
		currentspeaker = "player"
		if objectText[b].text[n]~= nil then
			text = objectText[b].text[n]
			wait.triggered = 1
			wait.n = string.len(text)
		else
			text = objectText[b].text[1]
			wait.triggered = 1
			wait.n = string.len(text)
		end
	end
end

function exitAction()
	if actionMode == 1 then
		player.canMove = 1
		actionMode = 0
		print("exitAction set dialogueMode to 0")
		dialogueMode = 0
		wait.triggered = 0
		keyInput = 1
		if choice.mode == 1 then
			choice.mode = 0
			choice.pos = 1
		end
	end
end


--pass object description to text, change dialogue mode
function printObjText(b, c)
	if actionMode == 0 then
		if dialogueMode == 0 then
      if b == "plantSmBerries" then
				if inventoryFull (player.maxInventory) == false then -- check if space in inventory
					if freeze.action == 0 then -- check if player has energy
						if movingObjectData[currentLocation][b][c].used == 0 then
							-- startAction(b, 1)
						  BerryHarvestStart(b, c)
							addRemoveItem("I got 1 Plum Berry.", "Plum Berries", 1, b, false)
							setBubble(b, c)
							actionMode = 0
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
							-- startAction(b, 1)
			        BerryHarvestStart(b, c)
							addRemoveItem("I got 1 Rose Berry.", "Rose Berries", 1, b, false)
							setBubble(b, c)
							actionMode = 0
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
			elseif b == "playerBed" then
				if player.sleep == true then
					startAction(b, 3)
					objectText[b].logic.yesno = true
					choice.pos = 1
					actionMode = 1
				else
					startAction(b, 1)
				end
			else
				print("Not berries or barrel obj: " .. b)
				startAction(b, c)
      end
		else
			print("printObjText set dialogueMode to 0")
			dialogueMode = 0
			player.canMove = 1
      wait.triggered = 0
			print("printObjText set wait off")
			sfx.textSelect:play()
		end
	elseif actionMode == 1 then
		-- if b == "barrelSmBerries" then
    --   BerryBarrel(b, c, "Plum Berries")
    --   return
    -- elseif b == "barrelLgBerries" then
    --   BerryBarrel(b, c, "Rose Berries")
    --   return
		if b == "playerBed" then
			if objectText[b].logic.yesno == true and player.sleep == true then
				if choice.mode == 0 then
					choice.mode = 1
					choice.total = 2
					choice.type = "yesno"
					choiceText(objectText.yesno.text, choice.pos, choice.total)
					return
				elseif choice.mode == 1 then
					if choice.pos == 1 then
						cutsceneControl.stage = 5
					end
					choice.mode = 0
					dialogueMode = 0
					player.canMove = 1
					choice.pos = 1
				end
			end
    end
		actionMode = 0
	end
end

--test to see if player facing object, retrieve description
function faceObject(char, dir, tbl)
	if dir == 1 then -- up
		local a, b, c = testObject(0, -1, tbl)
		if a and b ~= nil then
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
			if char == player then
				printObjText(b, c)
				return
			else
				return a, b, c
			end
		end
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

function resetBerries()
	for k, v in pairs(movingObjectData.overworld.plantSm) do
		movingObjectData.overworld.plantSm[k].anim = newAnimation(animsheet2, 0, 3, 16, 16, .3)
		movingObjectData.overworld.plantSm[k].trigger = 0
		movingObjectData.overworld.plantSm[k].picked = 0
		table.insert(movingObjectData.overworld.plantSmBerries, movingObjectData.overworld.plantSm[k])
		table.remove(movingObjectData.overworld.plantSm, k)
	end
	for k, v in pairs(movingObjectData.overworld.plantLg) do
		movingObjectData.overworld.plantLg[k].anim = newAnimation(animsheet2, 4*gridsize, 3, 16, 16, .3)
		movingObjectData.overworld.plantLg[k].trigger = 0
		movingObjectData.overworld.plantLg[k].picked = 0
		table.insert(movingObjectData.overworld.plantLgBerries, movingObjectData.overworld.plantLg[k])
		table.remove(movingObjectData.overworld.plantLg, k)
	end
	for k, v in pairs(movingObjectData.overworld.plantSmBerries) do
		movingObjectData.overworld.plantSmBerries[k].anim = newAnimation(animsheet2, 0, 3, 16, 16, .3)
		movingObjectData.overworld.plantSmBerries[k].trigger = 0
		movingObjectData.overworld.plantSmBerries[k].picked = 0
	end
	for k, v in pairs(movingObjectData.overworld.plantLgBerries) do
		movingObjectData.overworld.plantLgBerries[k].anim = newAnimation(animsheet2, 4*gridsize, 3, 16, 16, .3)
		movingObjectData.overworld.plantLgBerries[k].trigger = 0
		movingObjectData.overworld.plantLgBerries[k].picked = 0
	end
end

function resetBarrels()
	objectInventory.barrelSmBerries = 0
	objectInventory.barrelLgBerries = 0
end

itemEffects = {platefull2 = {type = "once", description = "Restores Energy", text = 1, func = energyMod, par = {50}},
							platefull3 = {type = "once", description = "Restores Energy", text = 1, func = energyMod, par = {50}}
							}
