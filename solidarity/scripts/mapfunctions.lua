-- --change location to battlefield
-- function battleMap(bMode, dMode) --battleMode, dialogueMode
--   if bMode == 1 and dMode == 0 then
--     storedLocation.x = player.grid_x
--     storedLocation.y = player.grid_y
--     currentLocation = "battlefield1"
--     locationMaps(currentLocation)
--     changeBackground(currentLocation)
--     player.grid_x = locationTriggers["battlefield1"][1][4]
--     player.act_x = player.grid_x
--     player.grid_y = locationTriggers["battlefield1"][1][5]
--     player.act_y = player.grid_y
--   end
-- end

-- --change location back to overworld
-- function battleEnd(x, y)
--   currentLocation = "overworld"
--   locationMaps(currentLocation)
--   changeBackground(currentLocation)
--   player.grid_x = x
--   player.act_x = player.grid_x
--   player.grid_y = y
--   player.act_y = player.grid_y
-- end

--generate new maps or load old ones for each area
function locationMaps(currentLocation)
	if currentLocation == "overworld" then
		mapFile1 = mapPath.overworld[1]
		print(currentLocation)
		mapGen (bg.overworld, mapFile1)
	elseif currentLocation == "gardeningShed" then
		mapFile1 = mapPath.gardeningShed[1]
		print(currentLocation)
		mapGen (bg.gardeningShed, mapFile1)
	elseif currentLocation == "battlefield1" then
		mapFile1 = mapPath.battlefield1[1]
		print(currentLocation)
		mapGen (bg.battlefield1, mapFile1)
	elseif currentLocation == "dormitory" then
		mapFile1 = mapPath.dormitory[1]
		print(currentLocation)
		mapGen (bg.dormitory, mapFile1)
	elseif currentLocation == "dininghall" then
		mapFile1 = mapPath.dininghall[1]
		print(currentLocation)
		mapGen (bg.dininghall, mapFile1)
	elseif currentLocation == "store" then
		mapFile1 = mapPath.store[1]
		print(currentLocation)
		mapGen (bg.store, mapFile1)
	end
end

-- if door is locked, add block to map
function doorLock(tbl)
	for i = 1, #tbl do
		if tbl[i].locked == 0 then
			addBlock (initTable, tbl[i].x, tbl[i].y, 0)
		elseif tbl[i].locked == 1 then
			print("adding blocks " .. tbl[i].x, tbl[i].y)
			addBlock (initTable, tbl[i].x, tbl[i].y, 1)
		end
	end
	saveMap()
end

--change location and map to match new location
function changeMap(px, py, tbl)
  for i = 1, #tbl do
    if px == tbl[i].x and py == tbl[i].y then
			if tbl[i].locked == 0 then
	      currentLocation = tbl[i].name
	      locationMaps(currentLocation)
				changeBackground(currentLocation)
				player.grid_x = tbl[i].x2
				player.act_x = player.grid_x
				player.grid_y = tbl[i].y2
				player.act_y = player.grid_y
				print(currentLocation)
			end
    end
  end
end

--change background to match location
function changeBackground(l)
	currentBackground = bg[l]
end


function mapSize (img, s)
  local width = img:getWidth()
  local height = img:getHeight()
  local tbl = {}
  for i = 1, height/s do
    tbl[i] = {}
    for k = 1, width/s do
      table.insert(tbl[i], 0)
    end
  end
return tbl
end

function fillEdges(tbl)
	local y = #tbl
	for i = 1, #tbl[1] do
		tbl[1][i] = 1
	end
	for i = 1, #tbl[y] do
		tbl[y][i] = 1
	end
end

function addTempBlocks(tbl)
	if tempBlocks[currentLocation] ~= nil then
		for i = 1, #tempBlocks[currentLocation] do
			if tempBlocks[currentLocation][i].on == 1 then
				local x = tempBlocks[currentLocation][i].x
				local y = tempBlocks[currentLocation][i].y
				tbl[y][x] = 1
			end
		end
	end
end

function removeTempBlocks(l, i) -- currentLocation, index
	if tempBlocks[l] ~= nil then
		if tempBlocks[l][i].on == 1 then
			tempBlocks[l][i].on = 0
			removeBlock(tempBlocks[l][i].x, tempBlocks[l][i].y)
		end
	end
end

function clearTempBlocks()
	for j = 1, #locationList do
		local l = locationList[j]
		if tempBlocks[l] ~= nil then
			for i = 1, #tempBlocks[l] do
				if tempBlocks[l][i].on == 0 then
					removeBlock(tempBlocks[l][i].x, tempBlocks[l][i].y)
				end
			end
		end
	end
end
-- check if a file exists
function file_exists(name)
	 local f=io.open(name,"r")
	 if f~=nil then io.close(f) print("true") return true else print("false") return false end
end

--generate map file or load current map to table
function mapGen (img, file1)
  print(mapExists)
	if file_exists(file1) then
		mapExists = 1
		f = assert(io.open(file1, "r"))
		local content = f:read("*a")
		initTable = json.decode(content)
		io.close(f)
		addTempBlocks(initTable)
		clearTempBlocks()
		doorLock(locationTriggers[currentLocation])
		saveMap()
	else
		mapExists = 0
		initTable = mapSize (img, gridsize)
		fillEdges(initTable)
		addTempBlocks(initTable)
		clearTempBlocks()
		doorLock(locationTriggers[currentLocation])
		f = assert(io.open(file1, "w"))
		initTableFile = json.encode(initTable)
		f:write(initTableFile)
		f:close(initTableFile)
		mapExists = 1
	end
end

function drawEditor (tbl)
  if tbl then
    for y=1, #tbl do
			for x=1, #tbl[y] do
        love.graphics.setColor(0, 0, 0)
				love.graphics.rectangle("line", (x * 16), (y * 16), 16, 16)
        if tbl[y][x] == 1 then
          love.graphics.setColor(200, 200, 200, 140)
          love.graphics.rectangle("fill", (x * 16), (y * 16), 16, 16)
        end
			end
		end
  end
end

function addBlock (tbl, x, y, n)
  print("triggered addblock")
  local k = math.floor(x/gridsize)
  local v = math.floor(y/gridsize)
	if debugView == 1 then
	  if tbl[v][k] == 0 then
	    tbl[v][k] = n
	  elseif tbl[v][k] == n then
	    tbl[v][k] = 0
	  end
	else
		if tbl[v][k] ~= n then
			tbl[v][k] = n
		end
	end
end

function saveMap()
	print("saved over old map")
	f = assert(io.open(mapFile1, "w"))
	initTableFile = json.encode(initTable)
	f:write(initTableFile)
	f:close(initTableFile)
end

-- add location of NPCs or other moving obstacles to map collision
function updateMap(tbl)
	clearMap(2)
	for i = 1, #tbl do
		if tbl == npcs then
			if tbl[i].location == currentLocation then
				addBlock (initTable, tbl[i].grid_x, tbl[i].grid_y, 2)
			end
		else
			addBlock (initTable, tbl[i].grid_x, tbl[i].grid_y, 2)
		end
	end
	saveMap()
end

--remove block from location
function removeBlock(x, y)
	if initTable[y][x] ~= nil then
		initTable[y][x] = 0
		saveMap()
	end
end

--remove block from all nodes with value corresponding to n
function clearMap(n)
	for v = 1, #initTable do
		for k = 1, #initTable[v] do
			if initTable[v][k] == n then
				initTable[v][k] = 0
			end
		end
	end
end
