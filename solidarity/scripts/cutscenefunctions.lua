function cutsceneStage1Talk()
  updateMap(npcs) -- add NPC locations to map and save
  addBlock (initTable, player.act_x, player.act_y, 2) -- add block for player location
  local n = cutsceneControl.current
  if cutsceneList[n].move == true then -- if npc is supposed to move
    local i = cutsceneList[n].npc
    local char = npcs[i]
    local target = cutsceneList[n].target
    local x1, y1 = target.act_x, target.act_y
    --enable movement for npc
    char.canMove = 1
    --remove block from moving NPC
    removeBlock(char.act_x/gridsize, char.act_y/gridsize)
    --check if there is space on all sides of target, return table with x, y, and facing
    local open = checkOpenSpace(x1, y1)
    --find path between npc location and target location (usually player)
    cutsceneList[n].path, cutsceneList[n].facing[1] = checkPaths(open, char, x1, y1)
  end
  cutsceneControl.stage = 2
end

function cutsceneStage2Talk(dt)
  player.canMove = 0
	local n = cutsceneControl.current
	local path = cutsceneList[n].path
	local i = cutsceneList[n].npc
	local char = npcs[i]
	local target = cutsceneList[n].target
	local x1, y1 = target.act_x, target.act_y
	local t = #cutsceneList[n].path
	if path then
    char.canMove = 1
    if char.act_x == char.grid_x and char.act_y == char.grid_y then
			if cutsceneList[n].noden < t then
				cutsceneList[n].noden = cutsceneList[n].noden + 1
				updateGridPosNPC(path, char, cutsceneList[n].noden)
				print("node n:" .. cutsceneList[n].noden)
			end
		end
  end
	char.moveDir, char.act_x, char.act_y = moveChar(char.moveDir, char.act_x, char.grid_x, char.act_y, char.grid_y, (char.speed *dt))
	if char.act_x == cutsceneList[n].path[t].x*gridsize and char.act_y == cutsceneList[n].path[t].y*gridsize then
		char.facing = cutsceneList[n].facing[1]
		target.facing = changeFacing(x1, y1, char.act_x, char.act_y)
		npcs[i].moveDir = 0
		cutsceneControl.stage = 3
	end
end

function cutsceneStage3Talk()
  local n = cutsceneControl.current
  local i = cutsceneList[n].npc
  npcs[i].c = cutsceneList[n].dialoguekey
  DialogueSetup(npcs, dialogueStage)
  cutsceneControl.stage = 4
end

function cutsceneStage4Talk(dt)
  local n = cutsceneControl.current
  local i = cutsceneList[n].npc
  local path = cutsceneList[n].path
  local char = npcs[i]
  if cutsceneList[n].goback == true then -- if character needs to return to start position
    player.canMove = 0
    table.insert(cutsceneList[n].facing, npcs[i].start)
    if path then
      if char.act_x == char.grid_x and char.act_y == char.grid_y then
        if cutsceneList[n].noden > 0 then
          cutsceneList[n].noden = cutsceneList[n].noden - 1
          updateGridPosNPC(path, char, cutsceneList[n].noden)
          print("node n:" .. cutsceneList[n].noden)
        end
      end
    end
    char.moveDir, char.act_x, char.act_y = moveChar(char.moveDir, char.act_x, char.grid_x, char.act_y, char.grid_y, (char.speed *dt))
    if char.act_x == cutsceneList[n].path[1].x*gridsize and char.act_y == cutsceneList[n].path[1].y*gridsize then
      char.facing = cutsceneList[n].facing[#cutsceneList[n].facing]
      npcs[i].moveDir = 0
      cutsceneControl.stage = 5
    end
  else
    npcs[i].canMove = 0
    cutsceneControl.stage = 5
  end
end

function changeGameStage()
  local n = cutsceneControl.current
  if cutsceneList[n].nextStage == true then
    gameStage = gameStage + 1
    dialogueStage = dialogueStage + 1
    print("gameStage" .. gameStage)
    if player.next[gameStage].x ~= 0 then
      player.grid_x = player.next[gameStage].x
      player.act_x = player.grid_x
    end
    if player.next[gameStage].y ~= 0 then
      player.grid_y = player.next[gameStage].y
      player.act_y = player.grid_y
    end
    if player.next[gameStage].facing ~= 0 then
      player.facing = player.next[gameStage].facing
    end
    player.location = player.next[gameStage].location
    for i = 1, #npcs do
      npcs[i].grid_x = npcs[i].next[gameStage].x
      npcs[i].act_x = npcs[i].next[gameStage].x
      npcs[i].grid_y = npcs[i].next[gameStage].y
      npcs[i].act_y = npcs[i].next[gameStage].y
      npcs[i].facing = npcs[i].next[gameStage].facing
      npcs[i].start = npcs[i].facing
      npcs[i].location = npcs[i].next[gameStage].location
      npcs[i].c = 1
      npcs[i].n = 1
      npcs[i].canMove = 0
    end
  end
end

function changeTime()
  print ("daytime " .. daytime)
  if daytime == 1 then
    daytime = 0
    currentBackground = bg.overworldnight
  else
    daytime = 1
    currentBackground = bg.overworld
  end
end
