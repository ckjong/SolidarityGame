-- test to see if player next to object, return object name
function testObject(x, y, tbl)
	local m = (player.grid_x / 16) + x
	local n = (player.grid_y / 16) + y
	if currentLocation == "overworld" then
		for i = 1, #tbl do
			if m*gridsize == tbl[i][2] and n*gridsize == tbl[i][3] then
				if tbl[i].off ~= nil then
					if tbl[i].off == 0 then
						return true, tbl[i][1], i
					else
						return false, nil
					end
				end
				return true, tbl[i][1], i
			end
		end
	end
	return false, nil
end

function inventoryFull(m)
	local total = 0
	if #player.inventory > 0 then
		for k = 1, #player.inventory do
			total = total + player.inventory[k].amount
			if total >= m then
				return true
			end
		end
		return false
	else
		return false
	end
end

function checkInventory(i)
  print("checking " .. i)
  if #player.inventory > 0 then
    print("#player.inventory " .. #player.inventory)
    for k = 1, #player.inventory do
      if player.inventory[k].item == i then
        -- check if item already in the inventory
        print("key " .. k)
        print(player.inventory[k].amount .. i .. " present")
        return 1, k
      end
    end
    print(i .. " not present")
    return 0
  else
    print("inventory empty")
    return 0
  end
end


function addRemoveItem(txt, i, a, b) -- text to display, item, amount, icon name
  wait.current = wait.start
  wait.triggered = 1
  text = txt
  local present, k = checkInventory(i)
  if present == 1 then
    player.inventory[k].amount = player.inventory[k].amount + a
    print(player.inventory[k].amount .. i .. "new amount present")
    if player.inventory[k].amount <= 0 then
      print(player.inventory[k].amount .. i .. "amount removed")
      player.inventory[k] = nil
      table.remove(player.inventory, k)
    end
  elseif present == 0 then
    if a > 0 then
      print(a .. i .. " added")
      -- if item not there, create new entry
      table.insert(player.inventory, {item = i, amount = a, icon = b})
    end
  end
end

--pass object description to text, change dialogue mode
function printObjText(b, c)
  print("object " .. b)
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
        BerryBarrel(b, c, "Plum Berries")
        return
      elseif b == "barrelLgBerries" then
				startAction(b, 1)
        BerryHarvestStart(b, c)
        BerryBarrel(b, c, "Rose Berries")
        return
			else
				startAction(b, 1)
      end
		else
			dialogueMode = 0
			player.canMove = 1
      wait.triggered = 0
		end
	elseif actionMode == 1 then
		if actions[1].current < actions[1].max then
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
				addRemoveItem("I got 10 Plum Berries", "Plum Berries", 10, b)
				movingObjectData[currentLocation][c][1] = "plantSm"
        movingObjectData[currentLocation][c][4] = 1
        actions[1].k = 0
			elseif b == "plantLgBerries" then
				addRemoveItem("I got 10 Rose Berries", "Rose Berries", 10, b)
				movingObjectData[currentLocation][c][1] = "plantLg"
        movingObjectData[currentLocation][c][4] = 1
        actions[1].k = 0
      elseif b == "barrelSmBerries" then
        BerryBarrel(b, c, "Plum Berries")
        return
      elseif b == "barrelLgBerries" then
        BerryBarrel(b, c, "Rose Berries")
        return
      end
			actions[1].current = 0
			actionMode = 0
		end
	end
end

--test to see if player facing object, retrieve description
function faceObject(dir, tbl)
	if dir == 1 then -- up
		local a, b, c = testObject(0, -1, tbl)
		if a and b ~= nil then
      storedIndex = c
			printObjText(b, c)
			return
		end
	elseif dir == 2 then -- down
		local a, b, c = testObject(0, 1, tbl)
		if a and b ~= nil then
      storedIndex = c
			printObjText(b, c)
			return
		end
	elseif dir == 3 then -- left
		local a, b, c = testObject(-1, 0, tbl)
		if a and b ~= nil then
      storedIndex = c
			printObjText(b, c)
			return
		end
	elseif dir == 4 then -- right
		local a, b, c = testObject(1, 0, tbl)
		if a and b ~= nil then
      storedIndex = c
			printObjText(b, c)
			return
		end
	end
end

-- berry harvest
function BerryHarvestStart(b, c)
  if b == "plantSmBerries" then
    actions[1].rate = 15
    actions[1].k = 1
    -- k = key for object animation
  elseif b == "plantLgBerries" then
    actions[1].rate = 10
    actions[1].k = 2
  elseif b == "barrelSmBerries" then
    actions[1].k = 3
    actions[1].current = actions[1].max
  elseif b == "barrelLgBerries" then
    actions[1].k = 4
    actions[1].current = actions[1].max
  end
  movingObjectData[currentLocation][c][4] = 0 -- hide still sprite
  actions[1].x = movingObjectData[currentLocation][c][2]
  actions[1].y = movingObjectData[currentLocation][c][3]
  actionMode = 1
end

function BerryBarrel(b, c, sub)
  local present, k = checkInventory(sub)
  if present == 1 then
		objectInventory[b] = objectInventory[b] + 10
    addRemoveItem("Dropped 10 " .. sub .. "\nThere are " .. objectInventory[b] .. " berries in the barrel.", sub, -10, b)
    wait.current = wait.start
    wait.triggered = 1
  else
    text = "I don't have any " .. sub .. "\nThere are " .. objectInventory[b] .. " berries in the barrel."
    wait.current = wait.start
    wait.triggered = 1
    movingObjectData[currentLocation][c][4] = 1
    actions[1].current = 0
    actions[1].k = 0
    actionMode = 0
  end
end

function exitAction()
	if actionMode == 1 then
		movingObjectData[currentLocation][storedIndex][4] = 1
		actions[1].k = 0
		actions[1].current = 0
		player.canMove = 1
		actionMode = 0
		dialogueMode = 0
	end
end

function startAction(b, n)
	wait.current = wait.start
	wait.triggered = 1
	dialogueMode = 1
	currentspeaker = "player"
	text = objectText[b][n]
end
