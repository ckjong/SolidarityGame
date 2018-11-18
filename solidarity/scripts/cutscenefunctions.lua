function cutsceneStage1Talk()
  updateMap(npcs) -- add NPC locations to map and save
  local n = cutsceneControl.current
  if cutsceneList[n].move == true then -- if npc is supposed to move
    local i = cutsceneList[n].npc
    local char = npcs[i]
    local target = cutsceneList[n].target
    local x1, y1 = target.grid_x, target.grid_y
    --enable movement for npc
    char.canMove = 1
    --remove block from moving NPC
    removeBlock(char.act_x/gridsize, char.act_y/gridsize)
    --find path between npc location and target location (usually player)
    cutsceneList[n].path, cutsceneList[n].facing[1] = checkPaths(char, x1, y1)
  end
  cutsceneControl.stage = 2
end

function cutsceneStage2Talk(dt)
  player.canMove = 0
  keyInput = 0
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
  print("#path " .. #path)
  if #path == 1 then cutsceneList[n].goback = false end -- if path is empty then don't go back to starting position
  if cutsceneList[n].goback == true then -- if character needs to return to start position
    if path then
      player.canMove = 0
      table.insert(cutsceneList[n].facing, npcs[i].start)
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

--set conditions for screen fade, or skip to stage 7 if no fade
function cutsceneStage5Talk()
  if cutsceneList[cutsceneControl.current].fadeout ~= 0 then
    fading.type = cutsceneList[cutsceneControl.current].fadeout
    fadeControl(fading.type)
    player.canMove = 0
    keyInput = 0
    fading.on = true
    cutsceneControl.stage = 6
  else
    cutsceneControl.stage = 7
  end
end

function cutsceneStage6Talk(dt)
  if fading.on == true then
    fading.a, fading.on = fade(dt, fading.a, fading.goal, fading.rate)
  else
    cutsceneControl.stage = 7
  end
end

function cutsceneStage7Talk()
  if cutsceneList[cutsceneControl.current].triggered == false then
    changeTime(cutsceneList[cutsceneControl.current].switchTime)
    changeGameStage()
    cutsceneList[cutsceneControl.current].triggered = true
  end
  if cutsceneControl.current < cutsceneControl.total then -- if there are more cutscenes advance to next one
    cutsceneControl.current = cutsceneControl.current + 1
    cutsceneControl.stage = 0
  else
    cutsceneControl.stage = 8
  end
end

function changeGameStage()
  local n = cutsceneControl.current
  if cutsceneList[n].nextStage == true then
    clearMap(2)
    saveMap()
    gameStage = gameStage + 1
    dialogueStage = dialogueStage + 1
    print("gameStage" .. gameStage)
    gameStageControl(gameStage)
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

function gameStageControl(g)
  if g == 1 then
    freeze.action = 0
    -- --turn off static text for barrels
    -- staticObjects.overworld[5].off = 1
    -- staticObjects.overworld[6].off = 1
  end
end

function changeTime(t)
  print ("daytime " .. daytime)
end

function fadeControl(t) -- arg: fading.type
  if t == 1 then
    fading.start = 0
    fading.goal = 255
    fading.rate = 140
    fading.a = fading.start
  elseif t == 2 then
    fading.start = 255
    fading.goal = 0
    fading.rate = 140
    fading.a = fading.start
  end
end

--change alpha to fade out or in image, delta time, current alpha, goal, rate
function fade(dt, a, b, r)
  if r > 0 then -- alpha going up
    if a <= b then
      a = a + r*dt
      print("alpha " .. a)
      return a, true
    else
      fading.countdown = .5
      fading.triggered = 1
      keyInput = 1
      print("fading off")
      return a, false
    end
  else
    if a >= b then
      a = a + r*dt
      return a, true
    else
      player.canMove = 1
      keyInput = 1
      print("fading off")
      return a, false
    end
  end
end

function fadeCountdown(dt)
  if fading.countdown > 0 then
    fading.countdown = fading.countdown - dt
  elseif fading.countdown < 0 then
    fading.countdown = 0
  elseif fading.countdown == 0 then
    if fading.triggered == 1 then
      fading.triggered = 0
      player.canMove = 1
    end
  end
end
