-- test to see if player next to object, return object name
function testObject(x, y, tbl)
	local m = (player.grid_x / 16) + x
	local n = (player.grid_y / 16) + y
	if currentLocation == "overworld" then
		for i = 1, #tbl do
			if m*gridsize == tbl[i][2] and n*gridsize == tbl[i][3] then
				return true, tbl[i][1], i
			end
		end
	end
	return false, nil
end


function addItem(txt, i, a) -- item, amount
  wait.current = wait.start
  wait.triggered = 1
  text = txt
  table.insert(player.inventory, {item = i, amount = a})
  dialogueMode = 1
end


--pass object description to text, change dialogue mode
function printObjText(b, c)
	if actionMode == 0 then
		if dialogueMode == 0 then
      wait.current = wait.start
      wait.triggered = 1
			dialogueMode = 1
			currentspeaker = "player"
			text = objectText[b][1]
			if b == "plantSmBerries" or b == "plantLgBerries" then
				if b == "plantSmBerries" then
					actions[1].rate = 10
					actions[1].k = 1
				else
					actions[1].rate = 5
					actions[1].k = 2
				end
				movingObjectData[currentLocation][c][4] = 0
				actions[1].x = movingObjectData[currentLocation][c][2]
				actions[1].y = movingObjectData[currentLocation][c][3]
				actionMode = 1
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
		else
			if b == "plantSmBerries" then
				addItem("You got 10 Plum Berries", "Plum Berries", 10)
				movingObjectData[currentLocation][c][1] = "plantSm"
			elseif b == "plantLgBerries" then
				addItem("You got 10 Rose Berries", "Rose Berries", 10)
				movingObjectData[currentLocation][c][1] = "plantLg"
			end
			actions[1].current = 0
			movingObjectData[currentLocation][c][4] = 1
			actionMode = 0
		end
	end
end

--test to see if player facing object, retrieve description
function faceObject(dir, tbl)
	if dir == 1 then -- up
		local a, b, c = testObject(0, -1, tbl)
		if a and b ~= nil then
			printObjText(b, c)
			return
		end
	elseif dir == 2 then -- down
		local a, b, c = testObject(0, 1, tbl)
		if a and b ~= nil then
			printObjText(b, c)
			return
		end
	elseif dir == 3 then -- left
		local a, b, c = testObject(-1, 0, tbl)
		if a and b ~= nil then
			printObjText(b, c)
			return
		end
	elseif dir == 4 then -- right
		local a, b, c = testObject(1, 0, tbl)
		if a and b ~= nil then
			printObjText(b, c)
			return
		end
	end
end
