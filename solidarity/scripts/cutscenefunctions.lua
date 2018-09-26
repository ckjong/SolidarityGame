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
  if cutsceneList[n].triggered == false then
    cutsceneList[n].triggered = true
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
    cutsceneControl.stage = 5
  end
end
