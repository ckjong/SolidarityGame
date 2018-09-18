--testmap for collision testing, update using map table
function testMap(x1, y1, x2, y2)
	if initTable[(y1 / gridsize) + y2][(x1 / gridsize) + x2] > 0 then
		return false
	end
	return true
end

--test to see if npc in the way of player
function testNPC(dir, x, y)
	for i = 1, #npcs do
		if currentLocation == npcs[i].location then
			local x2 = npcs[i].act_x
			local y2 = npcs[i].act_y
			if dir == 1 then
				if x == x2 and y - gridsize == y2 then
					return true
				end
			elseif dir == 2 then
				if x == x2 and y + gridsize == y2 then
					return true
				end
			elseif dir == 3 then
				if y == y2 and x - gridsize == x2 then
					return true
				end
			elseif dir == 4 then
				if y == y2 and x + gridsize == x2 then
					return true
				end
			end
		end
	end
	return false
end

--update grid position for moving NPCs during cutscenes
function updateGridPosNPC(tbl, char, n)
  total = #tbl
  char.grid_x = tbl[n].x*gridsize
  char.grid_y = tbl[n].y*gridsize
  if char.act_y > char.grid_y then
    char.moveDir = 1
    char.facing = 1
  elseif char.act_y < char.grid_y then
    char.moveDir = 2
    char.facing = 2
  elseif char.act_x > char.grid_x then
    char.moveDir = 3
    char.facing = 3
  elseif char.act_x < char.grid_x then
    char.moveDir = 4
    char.facing = 4
  end
  print("gridx, gridy:" .. char.grid_x, char.grid_y)
  print("actx, acty:" .. char.act_x, char.act_y)
end

--move character to another location if they enter a certain point
function moveCharBack(x1, y1, x2, y2, d)
	if player.act_x == x1*gridsize and player.act_y == y1*gridsize  then
		player.grid_x = x2*gridsize
		player.grid_y = y2*gridsize
		player.moveDir = d
		player.facing = d
	else
		trigger[1] = 0
	end
end

--change grid coordinates, up and down
function changeGridy(char, dir, x, y, s, col)
	char.facing = dir
	if col == 1 then
		if testMap(char.grid_x, char.grid_y, x, y) then
			if testNPC(dir, char.grid_x, char.grid_y) == false then
				if math.abs(char.grid_x - char.act_x) <= player.threshold then
					char.act_x = char.grid_x
					char.grid_y = char.grid_y + (s * gridsize)
					char.moveDir = dir
				end
			end
		end
	else
		if math.abs(char.grid_x - char.act_x) <= player.threshold then
			char.act_x = char.grid_x
			char.grid_y = char.grid_y + (s * gridsize)
			char.moveDir = dir
		end
	end
end

--change grid coordinates, left and right
function changeGridx(char, dir, x, y, s, col)
	char.facing = dir
	if col == 1 then
		if testMap(char.grid_x, char.grid_y, x, y) then
			if testNPC(dir, char.grid_x, char.grid_y) == false then
				if math.abs(char.grid_y - char.act_y) <= player.threshold then
					char.act_y = char.grid_y
					char.grid_x = char.grid_x + (s * gridsize)
					char.moveDir = dir
				end
			end
		end
	else
		if math.abs(char.grid_y - char.act_y) <= player.threshold then
			char.act_y = char.grid_y
			char.grid_x = char.grid_x + (s * gridsize)
			char.moveDir = dir
		end
	end
end


--
function updateGrid(char, c)
	if char.canMove == 1 then
		if love.keyboard.isDown("up") and char.act_y <= char.grid_y then
			changeGridy (char, 1, 0, -1, -1, c) -- char, dir, x-test, y-test, multiplier, collision
		elseif love.keyboard.isDown("down") and char.act_y >= char.grid_y then
			changeGridy (char, 2, 0, 1, 1, c)
		elseif love.keyboard.isDown("left") and char.act_x <= char.grid_x then
			changeGridx (char, 3, -1, 0, -1, c)
		elseif love.keyboard.isDown("right") and char.act_x >= char.grid_x then
			changeGridx (char, 4, 1, 0, 1, c)
		end
	end
end

-- test to see if player next to object, return object name
function testObject(x, y)
	local m = (player.grid_x / 16) + x
	local n = (player.grid_y / 16) + y
	for i = 1, #objects do
		if m == objects[i][1] and n == objects[i][2] then
			return true, objects[i][3]
		end
	end
	return false, nil
end

--pass object description to text, change dialogue mode
function printObjText(b)
	if dialogueMode == 0 then
		dialogueMode = 1
		text = objectText[b]
	else
		dialogueMode = 0
		player.canMove = 1
	end
end

--test to see if player facing object, retrieve description
function faceObject(dir)
	if dir == 1 then -- up
		local a, b = testObject(0, -1)
		if a and b ~= nil then
			printObjText(b)
			return
		end
	elseif dir == 2 then -- down
		local a, b = testObject(0, 1)
		if a and b ~= nil then
			printObjText(b)
			return
		end
	elseif dir == 3 then -- left
		local a, b = testObject(-1, 0)
		if a and b ~= nil then
			printObjText(b)
			return
		end
	elseif dir == 4 then -- right
		local a, b = testObject(1, 0)
		if a and b ~= nil then
			printObjText(b)
			return
		end
	end
end


--move character in direction of destination
function moveChar(m, x1, x2, y1, y2, s)--moveDir, act_x, grid_x, act_y, grid_y, speed
	if m == 1 then
		if y1 > y2 then
			y1 = y1 - s
		elseif y1 < y2 then
			y1 = y2
		elseif y1 == y2 then
			m = 0
		end
	elseif m == 2 then
		if y1 < y2 then
			y1 = y1 + s
		elseif y1 > y2 then
			y1 = y2
		elseif y1 == y2 then
			m = 0
		end
	elseif m == 3 then
		if x1 > x2 then
			x1 = x1 - s
		elseif x1 < x2 then
			x1 = x2
		elseif x1 == x2 then
			m = 0
		end
	elseif m == 4 then
		if x1 < x2 then
			x1 = x1 + s
		elseif x1 > x2 then
			x1 = x2
		elseif x1 == x2 then
			m = 0
		end
	end
	return m, x1, y1
end
