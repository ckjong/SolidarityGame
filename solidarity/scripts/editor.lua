--change location to battlefield
function battleMap(bMode, dMode) --battleMode, dialogueMode
  if bMode == 1 and dMode == 0 then
    storedLocation.x = player.grid_x
    storedLocation.y = player.grid_y
    currentLocation = "battlefield1"
    locationMaps(currentLocation)
    changeBackground(currentLocation)
    player.grid_x = locationTriggers["battlefield1"][1][4]
    player.act_x = player.grid_x
    player.grid_y = locationTriggers["battlefield1"][1][5]
    player.act_y = player.grid_y
  end
end

--change location back to overworld
function battleEnd(x, y)
  currentLocation = "overworld"
  locationMaps(currentLocation)
  changeBackground(currentLocation)
  player.grid_x = x
  player.act_x = player.grid_x
  player.grid_y = y
  player.act_y = player.grid_y
end

--generate new maps or load old ones for each area
function locationMaps(currentLocation)
	if currentLocation == "overworld" then
		mapFile1 = mapPath.overworld[1]
		mapFile2 = mapPath.overworld[2]
		print(currentLocation)
		mapGen (bg.overworld, mapFile1, mapFile2)
	elseif currentLocation == "gardeningShed" then
		mapFile1 = mapPath.gardeningShed[1]
		mapFile2 = mapPath.gardeningShed[2]
		print(currentLocation)
		mapGen (bg.gardeningShed, mapFile1, mapFile2)
	elseif currentLocation == "battlefield1" then
		mapFile1 = mapPath.battlefield1[1]
		mapFile2 = mapPath.battlefield1[2]
		print(currentLocation)
		mapGen (bg.battlefield1, mapFile1, mapFile2)
	end
end

--change location and map to match new location
function changeMap(px, py, tbl)
  for i = 1, #tbl do
    if px == tbl[i][1] and py == tbl[i][2] then
      currentLocation = tbl[i][3]
      locationMaps(currentLocation)
			changeBackground(currentLocation)
			player.grid_x = tbl[i][4]
			player.act_x = player.grid_x
			player.grid_y = tbl[i][5]
			player.act_y = player.grid_y
			print(currentLocation)
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

-- check if a file exists
function file_exists(name)
	 local f=io.open(name,"r")
	 if f~=nil then io.close(f) print("true") return true else print("false") return false end
end

--generate map file or load current map to table
function mapGen (img, file1, file2)
  print(mapExists)
	if file_exists(file2) then
		mapExists = 1
		f = assert(io.open(file2, "r"))
		local content = f:read("*a")
		initTable = json.decode(content)
		io.close(f)
		initTableFile = json.encode(initTable)
	else
		mapExists = 0
		initTable = mapSize (img, gridsize)
		fillEdges(initTable)
		f = assert(io.open(file1, "w"))
		initTableFile = json.encode(initTable)
		f:write(initTableFile)
		f:close(initTableFile)
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

function addBlock (tbl, x, y)
  print("triggered addblock")
  local k = math.floor(x/16)
  local v = math.floor(y/16)
  if tbl[v][k] == 0 then
    tbl[v][k] = 1
  elseif tbl[v][k] == 1 then
    tbl[v][k] = 0
  end
end
