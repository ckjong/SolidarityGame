function checkParty(char)
	for i = 1, #player.party do
		if player.party[i] == char.name then
			return true
		end
	end
	return false
end

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
			local nCol = checkParty(npcs[i])
			local x2 = npcs[i].act_x
			local y2 = npcs[i].act_y
			if nCol == false then
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
			else
				print("collision off for " .. npcs[i].name)
			end
		end
	end
	return false
end

--check to see if spaces next to target are free
function checkOpenSpace(x, y)
  local open = {}
  if testMap(x, y, 0, -1) then
    table.insert(open, 1) --x2, y2, direction NPC facing
  end
  if testMap(x, y, 0, 1) then
    table.insert(open, 2)
  end
  if testMap(x, y, -1, 0) then
    table.insert(open, 3)
  end
  if testMap(x, y, 1, 0) then
    table.insert(open, 4)
  end
  return open
end

--adjust char position to be facing direction based on location of other character, up down left right, or stay same
function changeFacing(x1, y1, x2, y2, f)
  if x1 == x2 and y1 > y2 then
    return 1
  elseif x1 == x2 and y1 < y2 then
    return 2
  elseif x1 > x2 and y1 == y2 then
    return 3
  elseif x1 < x2 and y1 == y2 then
    return 4
  else
    return f
  end
end



--make char face different directions every x seconds, ct = current time
function randomFacing(char, x, ct, dt)
	if ct > x then
		local tbl = checkOpenSpace(char.grid_x, char.grid_y)
		local i = math.random(#tbl)
		char.facing = tbl[i]
		char.timer.mt = math.random(3, 7)
		ct = ct - x
		return ct
	else
		ct = ct + dt
		return ct
	end
end

--check if there is a path to each open space, return path and direction npc facing at end
function checkPaths(char, x1, y1)
  local path = createPathNPC(math.floor(char.act_x/gridsize), math.floor(char.act_y/gridsize), x1/gridsize, y1/gridsize)
  if path ~= nil then
    print("path found")
		table.remove(path) -- remove last entry (player location)
		local facing = changeFacing(path[#path].x, path[#path].y, x1, y1) -- check which direction NPC must be facing
		return path, facing
	else
		error("no path found")
	end
end

function areaCheck(x1, y1, x2, y2, char)
	local x1, y1, x2, y2 = x1*gridsize, y1*gridsize, x2*gridsize, y2*gridsize
	if char.grid_x >= x1 and char.grid_x <= x2 and char.grid_y >= y1 and char.grid_y <= y2 then
		return true
	else
		return false
	end
end

function positionCheck(x, y, char)
	if (char.act_x - x) <= 0.05 and (char.act_y - y) <= 0.05 then
		return true
	else
		return false
	end
end

function checkDir(char)
	if math.abs(char.act_x - char.grid_x) < math.abs(char.act_y - char.grid_y) or char.act_x == char.grid_x then
		char.act_x = char.grid_x
		if char.act_y > char.grid_y then
			char.moveDir = 1
			char.facing = 1
		elseif char.act_y < char.grid_y then
			char.moveDir = 2
			char.facing = 2
		else
			char.moveDir = 0
		end
	elseif math.abs(char.act_x - char.grid_x) > math.abs(char.act_y - char.grid_y) or char.act_y == char.grid_y then
		char.act_y = char.grid_y
		if char.act_x > char.grid_x then
			char.moveDir = 3
			char.facing = 3
		elseif char.act_x < char.grid_x then
			char.moveDir = 4
			char.facing = 4
		else
			char.moveDir = 0
		end
	end
end

--update grid position for moving NPCs during cutscenes
function updateGridPosNPC(tbl, char, n)
  total = #tbl
  char.grid_x = tbl[n].x*gridsize
  char.grid_y = tbl[n].y*gridsize
  checkDir(char)
end

--move character to another location if they enter a certain point
function moveCharBack(x1, y1, x2, y2, d)
	if math.abs(player.act_x - x1*gridsize) < .1 and math.abs(player.act_y - y1*gridsize) < .1 then
		player.path[1] = {x = player.grid_x, y = player.grid_y}
		player.grid_x = x2*gridsize
		player.grid_y = y2*gridsize
		player.path[2] = {x = player.grid_x, y = player.grid_y}
		player.moveDir = d
		player.facing = d
		player.newDir = 1
	elseif player.act_x == x2*gridsize and player.act_y == y2*gridsize then
    if trigger[1] == 1 then
			player.canMove = 1
		  trigger[1] = 0
			keyInput = 1
    end
	end
end

--change grid coordinates, up and down
function changeGridy(char, dir, x, y, s, col)
	char.facing = dir
	if math.abs(char.grid_x - char.act_x) <= player.threshold then
		if col == 1 then
			if testMap(char.grid_x, char.grid_y, x, y) then
				if testNPC(dir, char.grid_x, char.grid_y) == false then
					char.act_x = char.grid_x
					char.path[1] = {x = char.grid_x, y = char.grid_y}
					char.grid_y = char.grid_y + (s * gridsize)
					char.moveDir = dir
					char.path[2] = {x = char.grid_x, y = char.grid_y}
					char.newDir = 1
					print("path x, y: " .. char.path[1].x .. char.path[1].y)
				end
			end
		else
			char.act_x = char.grid_x
			char.path[1] = {x = char.grid_x, y = char.grid_y}
			char.grid_y = char.grid_y + (s * gridsize)
			char.moveDir = dir
			char.facing = dir
			char.path[2] = {x = char.grid_x, y = char.grid_y}
			char.newDir = 1
		end
	end
end

--change grid coordinates, left and right
function changeGridx(char, dir, x, y, s, col)
	char.facing = dir
	if math.abs(char.grid_y - char.act_y) <= player.threshold then
		if col == 1 then
			if testMap(char.grid_x, char.grid_y, x, y) then
				if testNPC(dir, char.grid_x, char.grid_y) == false then
					char.act_y = char.grid_y
					char.path[1] = {x = char.grid_x, y = char.grid_y}
					char.grid_x = char.grid_x + (s * gridsize)
					char.moveDir = dir
					char.path[2] = {x = char.grid_x, y = char.grid_y}
					char.newDir = 1
					print("path x, y: " .. char.path[1].x .. char.path[1].y)
				end
			end
		else
			char.act_y = char.grid_y
			char.path[1] = {x = char.grid_x, y = char.grid_y}
			char.grid_x = char.grid_x + (s * gridsize)
			char.moveDir = dir
			char.facing = dir
			char.path[2] = {x = char.grid_x, y = char.grid_y}
			char.newDir = 1
		end
	end
end


--
function updateGrid(char, c)
	if char.canMove == 1 then
		if love.keyboard.isDown("up") and char.act_y <= char.grid_y then
			if love.keyboard.isDown("left", "right", "down") == false then
				changeGridy (char, 1, 0, -1, -1, c) -- char, dir, x-test, y-test, multiplier, collision
			end
		elseif love.keyboard.isDown("down") and char.act_y >= char.grid_y then
			if love.keyboard.isDown("left", "right", "up") == false then
				changeGridy (char, 2, 0, 1, 1, c)
			end
		elseif love.keyboard.isDown("left") and char.act_x <= char.grid_x then
			if love.keyboard.isDown("up", "down", "right") == false then
				changeGridx (char, 3, -1, 0, -1, c)
			end
		elseif love.keyboard.isDown("right") and char.act_x >= char.grid_x then
			if love.keyboard.isDown("up", "down", "left") == false then
				changeGridx (char, 4, 1, 0, 1, c)
			end
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

function partyFollows(dt, i, char)
	if dialogueMode == 0 then
		if player.newDir == 1 then
			npcs[i].path[1].x, npcs[i].path[1].y = npcs[i].grid_x, npcs[i].grid_y
			npcs[i].grid_x = char.path[1].x
			npcs[i].grid_y = char.path[1].y
			npcs[i].path[2].x, npcs[i].path[2].y = npcs[i].grid_x, npcs[i].grid_y
			checkDir(npcs[i])
			print("npc x, y: " .. npcs[i].grid_x .. npcs[i].grid_y)
		end
	end
end

function limitDistance(x1, x2, y1, y2, dist) -- char x, player x
	if math.abs(y2-y1) > dist then
		if x1 == x2 then
			if y1 > y2 then
				y1 = y2 + dist
				print(y1 .. " return y1")
			elseif y1 < y2 then
				y1 = y2 - dist
				print(y1 .. " return y1")
			end
		end
	end
	if math.abs(x2-x1) > dist then
		if y1 == y2 then
			if x1 > x2 then
				x1 = x2 + dist
				print(x1 .. " return x1")
			elseif x1 < x2 then
				x1 = x2 - dist
				print(x1 .. " return x1")
			end
		end
	end
	return x1, y1
end
