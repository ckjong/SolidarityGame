


function love.load()

	--code for navigating between maps
	require("scripts/drawfunctions")
	--json for map files
	json = require("json")


--map
	gridsize = 16
	debugView = 0
	infoView = 0
	mapExists = 0
	locationTriggers = {
										overworld = {
											{17*gridsize, 16*gridsize, "gardeningShed", 6*gridsize, 12*gridsize}},
										gardeningShed = {
											{6*gridsize, 13*gridsize, "overworld", 17*gridsize, 17*gridsize}},
										battlefield1 = {
											{nil, nil, "battlfield1", 3*gridsize, 6*gridsize}}
									}
	currentLocation = "overworld"
	mapPath = {overworld = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\scripts\\map.txt",
	"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\map1.txt"},
	gardeningShed = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\scripts\\map.txt",
	"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\map2.txt"},
	battlefield1 = {"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\scripts\\map.txt",
	"C:\\Users\\Carolyn\\Documents\\GitHub\\SolidarityGame\\solidarity\\maps\\map3.txt"}
}

	mapFile1 = nil
	mapFile2 = nil
--characters
	player = {
		grid_x = 17*gridsize,
		grid_y = 18*gridsize,
		act_x = 17*gridsize,
		act_y = 18*gridsize,
		speed = 32,
		canMove = 1,
		moveDir = 0,
		threshold = 0,
		facing = 2,
		name = "Saffron",
		battlestats = {hp = 2, damage = 1},
		inventory = {},
		party = {"Fennel", "Mint"}
	}

	npcs = {{
		grid_x = 18*gridsize,
		grid_y = 30*gridsize,
		act_x = 18*gridsize,
		act_y = 30*gridsize,
		speed = 30,
		canMove = 0,
		moveDir = 0,
		threshold = 0,
		facing = 1, --direction currently facing
		start = 1, --direction facing when starting
		location = "overworld",
		dialogue = 0,
		name = "Fennel",
		status = "worker",
		animationkey = 5, -- where animations start
		n = 1, --stage in single conversation
		c = 1, -- dialogue case
		battlestats = {hp = 2, damage = 1}
		},
		{
			grid_x = 14*gridsize,
			grid_y = 22*gridsize,
			act_x = 14*gridsize,
			act_y = 22*gridsize,
			speed = 30,
			canMove = 0,
			moveDir = 0,
			threshold = 0,
			facing = 1,
			start = 2,
			location = "overworld",
			dialogue = 0,
			name = "Mint",
			status = "worker",
			animationkey = 9,
			n = 1,
			c = 1,
			battlestats = {hp = 2, damage = 1}
			},
			{
				grid_x = 10*gridsize,
				grid_y = 27*gridsize,
				act_x = 10*gridsize,
				act_y = 27*gridsize,
				speed = 30,
				canMove = 0,
				moveDir = 0,
				threshold = 0,
				facing = 1,
				start = 4,
				location = "overworld",
				dialogue = 0,
				name = "Lark",
				status = "boss",
				animationkey = 13, -- where animations start
				n = 1, --stage in single conversation
				c = 1,
				battlestats = {hp = 5, damage = 1}}
}

	storedLocation = {x = 0, y = 0}
--battle
	battleMode = 0
	battleGlobal = {maxmoves = #player.party + 2, movesTaken = 0, turn = 0}

	--objects
	objects = {
		{16, 17, "GardeningSign"},
		{23, 17, "KitchenSign"},
	 	{29, 26, "DormitorySign"},
		{29, 34, "MixingSign"}
	}
--images
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setColor(0, 0, 0)
	love.graphics.setBackgroundColor(255,255,255)


	bg = {overworld = love.graphics.newImage("images/solidarity_overworld.png"),
				gardeningShed = love.graphics.newImage("images/utopia_gardeningshedbg.png"),
				battlefield1 = love.graphics.newImage("images/solidarity_battletest.png")}
	currentBackground = bg.overworld

	spritesheet1 = love.graphics.newImage("images/utopia.png")
	animsheet1 = love.graphics.newImage("images/solidarity_anim.png")
	ui = {arrowright = love.graphics.newImage("images/utopiaui_0.png"),
		arrowdown = love.graphics.newImage("images/utopiaui_5.png"),
		pressz = love.graphics.newImage("images/utopiaui_6.png")
		}
	toptiles = {gardeningShed = love.graphics.newImage("images/utopia_toptiles_0.png")}

--spritesheet, number of tiles in animation, starting position, length, width, height, duration
	animations = {{newAnimation(animsheet1, 0, 4, 16, 16, .6), "player.walkup"},
				 {newAnimation(animsheet1, 1*16, 4, 16, 16, .6), "player.walkdown"},
				 {newAnimation(animsheet1, 2*16, 4, 16, 16, .65), "player.walkleft"},
				 {newAnimation(animsheet1, 3*16, 4, 16, 16, .65), "player.walkright"},
			 	 {newAnimation(animsheet1, 4*16, 4, 16, 16, .6 ), "npcs[1].walkup"},
			   {newAnimation(animsheet1, 5*16, 4, 16, 16, .6 ), "npcs[1].walkdown"},
			 	 {newAnimation(animsheet1, 6*16, 4, 16, 16, .65 ), "npcs[1].walkleft"},
				 {newAnimation(animsheet1, 7*16, 4, 16, 16, .65 ), "npcs[1].walkright"},
				 {newAnimation(animsheet1, 8*16, 4, 16, 16, .6 ), "npcs[2].walkup"},
				 {newAnimation(animsheet1, 9*16, 4, 16, 16, .6 ), "npcs[2].walkdown"},
				 {newAnimation(animsheet1, 10*16, 4, 16, 16, .65 ), "npcs[2].walkleft"},
				 {newAnimation(animsheet1, 11*16, 4, 16, 16, .65 ), "npcs[2].walkright"},
				 {newAnimation(animsheet1, 12*16, 4, 16, 16, .6 ), "npcs[3].walkup"},
				 {newAnimation(animsheet1, 13*16, 4, 16, 16, .6 ), "npcs[3].walkdown"},
				 {newAnimation(animsheet1, 14*16, 4, 16, 16, .65 ), "npcs[3].walkleft"},
				 {newAnimation(animsheet1, 15*16, 4, 16, 16, .65 ), "npcs[3].walkright"}
			 }

--dialogue
	font = love.graphics.setNewFont("fonts/pixel.ttf", 8)
	dialogueMode = 0
	choice = {mode = 0, pos = 1, total = 1, name = "", case = 0, more = 0}
	text = nil

	--dialogue and object descriptions
	require("scripts/dialogue")

--timer for blinking text/images
	timer = {base = .5, current = 0, trigger = 0}
--editor for creating new maps
	require("scripts/editor")

	--generate map
	mapFile1 = mapPath.overworld[1]
	mapFile2 = mapPath.overworld[2]
	mapGen (bg.overworld, mapFile1, mapFile2)
	--table.save(initTable, "D:\\my game projects\\utopia\\scripts\\initTable.lua")
end


function love.update(dt)
	if timer.current > 0 then
		timer.current = timer.current - dt
	else
		if timer.trigger == 0 then
			timer.trigger = 1
		else
		 timer.trigger = 0
		end
		timer.current = timer.base
	end
	--immobilize player if dialoguemode active
	if dialogueMode == 1 then
		player.canMove = 0
	end

--set direction and destination position
	if debugView == 0 then
		if player.canMove == 1 then
			if love.keyboard.isDown("up") and player.act_y <= player.grid_y then
				changeGridy (player, 1, 0, -1, -1) -- char, dir, x-test, y-test, multiplier
			elseif love.keyboard.isDown("down") and player.act_y >= player.grid_y then
				changeGridy (player, 2, 0, 1, 1)
			elseif love.keyboard.isDown("left") and player.act_x <= player.grid_x then
				changeGridx (player, 3, -1, 0, -1)
			elseif love.keyboard.isDown("right") and player.act_x >= player.grid_x then
				changeGridx (player, 4, 1, 0, 1)
			end
		end
	elseif debugView == 1 then
		if player.canMove == 1 then
			if love.keyboard.isDown("up") and player.act_y <= player.grid_y then
				player.facing = 1
				if math.abs(player.grid_x - player.act_x) <= player.threshold then
					player.act_x = player.grid_x
					player.grid_y = player.grid_y - gridsize
					player.moveDir = 1
				end
			elseif love.keyboard.isDown("down") and player.act_y >= player.grid_y then
				player.facing = 2
				if math.abs(player.grid_x - player.act_x) <= player.threshold then
					player.act_x = player.grid_x
					player.grid_y = player.grid_y + gridsize
					player.moveDir = 2
				end
			elseif love.keyboard.isDown("left") and player.act_x <= player.grid_x then
				player.facing = 3
				if math.abs(player.grid_y - player.act_y) <= player.threshold then
					player.act_y = player.grid_y
					player.grid_x = player.grid_x - gridsize
					player.moveDir = 3
				end
			elseif love.keyboard.isDown("right") and player.act_x >= player.grid_x  then
				player.facing = 4
				if math.abs(player.grid_y - player.act_y) <= player.threshold then
					player.act_y = player.grid_y
					player.grid_x = player.grid_x + gridsize
					player.moveDir = 4
				end
			end
		end
	end

	player.moveDir, player.act_x, player.act_y = moveChar(player.moveDir, player.act_x, player.grid_x, player.act_y, player.grid_y, (player.speed *dt))

	if player.canMove == 1 then
		changeMap(player.act_x, player.act_y, locationTriggers[currentLocation])
	end

	--animation time update
	for k, v in pairs(animations) do
		animations[k][1]["currentTime"] = animations[k][1]["currentTime"] + dt
    if animations[k][1]["currentTime"] >= animations[k][1]["duration"] then
        animations[k][1]["currentTime"] = animations[k][1]["currentTime"] - animations[k][1]["duration"]
    end
	end
end


-- DRAW --
---------------

function love.draw()
	local width = love.graphics.getWidth( )
	local height = love.graphics.getHeight()
	local scale = {x=4, y=4}
	local translate = {x = (width - gridsize*scale.x) / 2, y = (height - gridsize*scale.y) /2}
	love.graphics.push()
	--camera move and scale
	love.graphics.translate(-player.act_x*scale.x + translate.x, -player.act_y*scale.y + translate.y)
	love.graphics.scale( scale.x, scale.y )

	-- draw background
	love.graphics.setBackgroundColor(93, 43, 67)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(currentBackground, 16, 16)

	--draw map
	if debugView == 1 then
		love.graphics.setColor(0, 0, 0)
		drawEditor (initTable)
	end

	--draw extra infoView
	if infoView == 1 then
		love.graphics.setColor(0, 0, 0)
		love.graphics.print(currentLocation, player.act_x - 48, player.act_y - 48)
		love.graphics.print("x: " .. player.act_x .." y: " .. player.act_y, player.act_x - 48, player.act_y - 40)
	end

	--render player
	love.graphics.setColor(255, 255, 255)
	drawPlayer()

	--render npcs
	drawNPCs()

	-- render tiles on top of player
	if currentLocation == "gardeningShed" then
		drawTop(currentLocation, locationTriggers)
	end

	--render dialogue box and text
	if text ~= nil and dialogueMode == 1 then
		local width = love.graphics.getWidth( )/4
		local height = love.graphics.getHeight( )/4
		local recheight = 32
		local recwidth = width-8
		local xnudge = 12
		local ynudge = 2
		local boxposx = player.act_x - (width/2) + xnudge
		local boxposy = player.act_y + (height/2) - recheight + ynudge
		love.graphics.setColor(93, 43, 67)
		love.graphics.rectangle("fill", boxposx, boxposy, recwidth, recheight) -- outside box (dark)
		love.graphics.setColor(255, 247, 220)
		love.graphics.rectangle("fill", boxposx+2, boxposy+2, recwidth-4, recheight-4) -- inside box (light colored)

		--draw z or arrow if more text
		drawArrow()

		--draw arrow for choices, shift text if arrow present
		drawText(boxposx +4, boxposy + 4)

	end

	love.graphics.pop()
end


function love.keypressed(key)

--initiate debug mode
  if key == "p" then
	 	if debugView == 0 then
    	debugView = 1
		elseif debugView == 1 then
			debugView = 0
		end
  end
--print additional info about game on screen for debugging
	if key == "i" then
		if infoView == 0 then
			infoView = 1
		else
			infoView = 0
		end
	end
--- interact with objects or people
  if key == "z" then
		DialogueSetup(npcs)
		faceObject(player.facing)
	end
-- add block to editor
	if key == "space" and debugView == 1 then
		addBlock (initTable, player.grid_x, player.grid_y)
	end

	if key == "s" and debugView == 1 then
		if mapExists == 1 then
			print("saved over old map")
			f = assert(io.open(mapFile2, "w"))
			initTableFile = json.encode(initTable)
			f:write(initTableFile)
			f:close(initTableFile)
		else
			print("saved over new map")
			f = assert(io.open(mapFile1, "w"))
			initTableFile = json.encode(initTable)
			f:write(initTableFile)
			f:close(initTableFile)
		end
	end

-- move between dialogue options
	if choice.mode == 1 then
		if key == "down" then
			if choice.pos >= 1 and choice.pos < choice.total then
				choice.pos = choice.pos + 1
				choiceText(NPCdialogue[choice.name][choice.case].text, choice.pos, choice.total)
			end
		elseif key == "up" then
			if choice.pos > 1 then
				choice.pos = choice.pos - 1
				choiceText(NPCdialogue[choice.name][choice.case].text, choice.pos, choice.total)
			end
		end
	end

-- end battle
	if battleMode == 1 and currentLocation == "battlefield1" then
		if key == "escape" then
			battleEnd(storedLocation.x, storedLocation.y)
		end
	end
end


--testmap for collision testing, update using map table
function testMap(x, y)
	if initTable[(player.grid_y / 16) + y][(player.grid_x / 16) + x] == 1 then
		return false
	end
	return true
end

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

--change grid coordinates, up and down
function changeGridy(char, dir, x, y, s)
	char.facing = dir
	if testMap(x, y) then
		if testNPC(dir, char.grid_x, char.grid_y) == false then
			if math.abs(char.grid_x - char.act_x) <= char.threshold then
				char.act_x = char.grid_x
				char.grid_y = char.grid_y + (s * gridsize)
				char.moveDir = dir
			end
		end
	end
	return
end

--change grid coordinates, left and right
function changeGridx(char, dir, x, y, s)
	char.facing = dir
	if testMap(x, y) then
		if testNPC(dir, char.grid_x, char.grid_y) == false then
			if math.abs(char.grid_y - char.act_y) <= char.threshold then
				char.act_y = char.grid_y
				char.grid_x = char.grid_x + (s * gridsize)
				char.moveDir = dir
			end
		end
	end
	return
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
		return
	else
		dialogueMode = 0
		player.canMove = 1
		return
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
function moveChar(m, x1, x2, y1, y2, s)
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

--animation
function newAnimation(image, start, length, width, height, duration)
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};
	for y = start, start, height do
    for x = 0, length * width - width, width do
      table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  end
  animation.duration = duration or 1
  animation.currentTime = 0
  return animation
end

--initiate dialogue
function initDialogue (char)
	if currentLocation == char.location then
		if player.act_y == char.act_y then
			if player.act_x == char.act_x - gridsize and player.facing == 4 then
				char.dialogue = 1
				char.facing = 3
				return true
			elseif player.act_x == char.act_x + gridsize and player.facing == 3 then
				char.dialogue = 1
				char.facing = 4
				return true
			end
		end
		if player.act_x == char.act_x then
			if player.act_y == char.act_y - gridsize and player.facing == 2 then
				char.dialogue = 1
				char.facing = 1
				return true
			elseif player.act_y == char.act_y + gridsize and player.facing == 1 then
				char.dialogue = 1
				char.facing = 2
				return true
			end
		end
	end
char.dialogue = 0
return false
end


function textUpdate (num, currentTbl)
	print("textUpdate triggered")
	dialogueMode = 1
	player.canMove = 0
	text = currentTbl.logic.speaker .. ": " .. currentTbl.text[num]
end

--dialogue off
function dialogueOff(tbl, i, next) -- tbl = npcs
	print("dialogueOff triggered")
	choice.more = 0
	dialogueMode = 0
	player.canMove = 1
	tbl[i].n = 1
	tbl[i].c = next
	tbl[i].dialogue = 0
end


--choice text
function choiceText(tbl, pos, total) -- tbl = NPCdialogue[name][case], pos = choice.pos, total = choice.total
	dialogueMode = 1
	player.canMove = 0
	local t = {}
	local n = 1
	local m = 1
	if pos == 1 then
		n = 2
	elseif pos == total then
		m = 2
	end
	for i = pos - m, pos + n do
		if tbl[i] ~= nil then
			table.insert(t, tbl[i] .. "\n")
		end
	end
	text = table.concat(t)
end


function DialogueSetup (tbl) -- iterate through npcs table, lookup text in NPCdialogue
	for i = 1, #tbl do
		if initDialogue(tbl[i]) == true then
			local name = tbl[i].name
			local num = tbl[i].n
			local case = tbl[i].c
			local dialOpt = NPCdialogue[name][case]
			if dialOpt.logic.cond == true then
				if dialOpt.logic.display == 1 then
					if num <= #dialOpt.text then -- if there are more lines to say, advance through table
						textUpdate(num, dialOpt)
						tbl[i].n = num + 1
						return
					else
						print("num > dialogue lines " .. tbl[i].n)
						if dialOpt.logic.off == true then
							dialogueOff(tbl, i, dialOpt.logic.next)
							return
						else
							tbl[i].n = 1
							tbl[i].c = dialOpt.logic.next
							DialogueSetup (tbl)
						end
					end
				end
				if dialOpt.logic.display == 2 then
					print("triggered display 2")
					if choice.mode == 0 then -- if choice has not been made yet
						choice.mode = 1
						choice.total = #dialOpt.text
						choice.name = name
						choice.case = case
						choiceText(dialOpt.text, choice.pos, choice.total) -- display dialogue options
						tbl[i].c = dialOpt.logic.next
						return
					end
				end
				if dialOpt.logic.display == 3 then
					if choice.mode == 1 then -- if choice has been made
						textUpdate (choice.pos, NPCdialogue[name][case]) -- display response
						if dialOpt.logic.trigger ~= nil then
							if dialOpt.logic.trigger.choice == choice.pos then
								if dialOpt.logic.trigger.type == "battle" then
									battleMode = 1
									choice.mode = 0
									tbl[i].c = dialOpt.logic.next
									dialogueOff(tbl, i, dialOpt.logic.next)
									--change location to battlefield if battleMode active and dialogue finished
									battleMap(battleMode, dialogueMode)
									return
								end
							end
						end
						choice.mode = 0
						tbl[i].c = dialOpt.logic.next
						return
					else
						if dialOpt.logic.off == true then
							dialogueOff(tbl, i, dialOpt.logic.next)
						else
							tbl[i].n = 1
							tbl[i].c = dialOpt.logic.next
							DialogueSetup (tbl)
						end
					end
				end
			end
		end
	end
end
