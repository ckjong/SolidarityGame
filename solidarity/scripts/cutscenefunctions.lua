function countTbl(tbl)
  local count = 0
  for k, v in pairs(tbl) do
    count = count + 1
  end
  return count
end

function sleepCheck(bool)
  if bool == true then
    if time == 2 then
      player.sleep = true
    end
  else
    player.sleep = false
  end
end

function closeGates()
  tempBlocks.overworld[2].on = 1
  tempBlocks.overworld[3].on = 1
  print("tempblocks 2 and 3 on")
  nonInteractiveObjects.overworld.fenceopenL[1].visible = 0
  nonInteractiveObjects.overworld.fenceopenR[1].visible = 0
  nonInteractiveObjects.overworld.fenceclosedL[1].visible = 1
  nonInteractiveObjects.overworld.fenceclosedR[1].visible = 1
  addTempBlocks(initTable)
  saveMap()
end

function openGates()
  for i = 1, #tempBlocks.overworld do
    tempBlocks.overworld[i].on = 0
  end
  nonInteractiveObjects.overworld.fenceopenL[1].visible = 1
  nonInteractiveObjects.overworld.fenceopenR[1].visible = 1
  nonInteractiveObjects.overworld.fenceclosedL[1].visible = 0
  nonInteractiveObjects.overworld.fenceclosedR[1].visible = 0
end

function cutsceneTrigger()
  if menuView == 0 and dialogueMode == 0 then
    if gameStage == 0 then
      if checkSpoken(npcs, NPCdialogue[dialogueStage], 6) == true then
        if cutsceneControl.stage == 0 then
          local n = cutsceneControl.current
          if cutsceneList[n].triggered == false then
            print("spoken to everyone, cutscene 1 triggered")
            cutsceneControl.stage = 1
          end
        end
      end
      if player.energy == 0 then
        if text == "I'm too tired to work." and dialogueMode == 0 then
          if cutsceneControl.stage == 0 then
            local n = cutsceneControl.current
            if cutsceneList[n].triggered == false then
              print("out of energy, cutscene 1 triggered")
              cutsceneControl.stage = 1
            end
          end
        end
      end
    elseif gameStage == 1 then
      if currentLocation == "dininghall" then
        if cutsceneControl.stage == 0 then
          local n = cutsceneControl.current
          if cutsceneList[n].triggered == false then
            print("Agave approaches, cutscene 2 triggered")
            player.canMove = 0
            cutsceneControl.stage = 1
          end
        end
      end
    elseif gameStage == 4 then
      if currentLocation == "dininghall" and workStage == 3 then
        if cutsceneControl.stage == 0 then
          local n = cutsceneControl.current
          if cutsceneList[n].triggered == false then
            print("cutscene 5 triggered")
            player.canMove = 0
            cutsceneControl.stage = 1
          end
        end
      end
    elseif gameStage == 5 then
      if checkSpoken(npcs, NPCdialogue[dialogueStage], 11) == true then
        if cutsceneControl.stage == 0 then
          local n = cutsceneControl.current
          if cutsceneList[n].triggered == false then
            print("spoken to everyone, cutscene 6 triggered")
            local i = getCharIndex("Ani")
            changeCharLoc(npcs[i], "dininghall")
            cutsceneControl.stage = 1
          end
        end
      end
    end
  end
end

--update map and find path
function cutsceneStage1Talk()
  print("cutscene stage 1")
  updateMap(npcs) -- add NPC locations to map and save
  local n = cutsceneControl.current
  if cutsceneList[n].move == true then -- if npc is supposed to move
    local i = getCharIndex(cutsceneList[n].npc)
    local char = npcs[i]
    local target = cutsceneList[n].target
    local x1, y1 = target.grid_x, target.grid_y
    --remove block from moving NPC
    removeBlock(char.grid_x/gridsize, char.grid_y/gridsize)
    --enable movement for npc
    char.canMove = 1
    char.canWork = 0
    char.working = 0
    local x2, y2 = round(player.act_x/gridsize)*gridsize, round(player.act_y/gridsize)*gridsize
    if target ~= player then
      addBlock(initTable, x2, y2, 2)
    end
    --find path between npc location and target location (usually player)
    if cutsceneList[n].targetIndex ~= nil then
      cutsceneList[n].path, cutsceneList[n].facing[1] = checkPaths(char, x1, y1, false, target.facing)
    else
      cutsceneList[n].path, cutsceneList[n].facing[1] = checkPaths(char, x1, y1, true)
    end
  end
  cutsceneControl.stage = 2
end

--walk to target
function cutsceneStage2Talk(dt)
  print("cutscene stage 2")
  player.canMove = 0
  keyInput = 0
	local n = cutsceneControl.current
	local i = getCharIndex(cutsceneList[n].npc)
	local char = npcs[i]
  if cutsceneList[n].move == true then
    local path = cutsceneList[n].path
    local target = cutsceneList[n].target
    local x1, y1 = target.grid_x, target.grid_y
    local t = #cutsceneList[n].path
    if path then
      char.canMove = 1
      if char.act_x == char.grid_x and char.act_y == char.grid_y then
        if cutsceneList[n].noden < t then
          cutsceneList[n].noden = cutsceneList[n].noden + 1
          updateGridPosNPC(path, char, cutsceneList[n].noden)
          print("node n:" .. cutsceneList[n].noden)
        else
          if math.abs(path[t].x - target.grid_x/gridsize) > 1 then
            cutsceneList[n].path[t].x = target.grid_x/gridsize
            char.grid_x = target.grid_x
            char.act_x = char.grid_x
          end
          if math.abs(path[t].x - target.grid_x/gridsize) > 1 then
            cutsceneList[n].path[t].y = target.grid_y
            char.grid_y = target.grid_y
            char.act_y = char.grid_y
          end
        end
     end
    end
    char.moveDir, char.act_x, char.act_y = moveChar(char.moveDir, char.act_x, char.grid_x, char.act_y, char.grid_y, (char.speed *dt))
    if char.act_x == cutsceneList[n].path[t].x*gridsize and char.act_y == cutsceneList[n].path[t].y*gridsize then
      npcs[i].facing = cutsceneList[n].facing[1]
      print(npcs[i].facing)
      target.facing = changeFacing(x1, y1, char.act_x, char.act_y, 1)
      npcs[i].moveDir = 0
      cutsceneControl.stage = 3
    end
  else
    cutsceneControl.stage = 3
  end
end

--dialogue
function cutsceneStage3Talk()
  print("cutscene stage 3")
  local n = cutsceneControl.current
  local i = getCharIndex(cutsceneList[n].npc)
  npcs[i].c = cutsceneList[n].dialoguekey
  if cutsceneList[n].forcetalk ~= nil then
    if cutsceneList[n].forcetalk == true then
      -- if dialogueStage[npcs[i].name][gameStage][npcs[i].c].logic.spoken == 0 then
      npcs[i].dialogue = 1
      DialogueSetup(npcs, dialogueStage, i)
      -- end
    end
  else
    print("Dialogue setup triggered stage " .. dialogueStage)
    DialogueSetup(npcs, dialogueStage)
  end
  cutsceneControl.stage = 4
end

--return to starting position
function cutsceneStage4Talk(dt)
  print("cutscene stage 4")
  local n = cutsceneControl.current
  local i = getCharIndex(cutsceneList[n].npc)
  local char = npcs[i]
  if cutsceneList[n].move == true then
    local path = cutsceneList[n].path
    print("#path " .. #path)
    if #path == 1 then cutsceneList[n].goback = false end -- if path is empty then don't go back to starting position
    if cutsceneList[n].goback == true then -- if character needs to return to start position
      if path then
        if player.canMove == 1 then
          player.canMove = 0
          keyInput = 0
        end
        if cutsceneList[n].facing ~= npcs[i].start then
          table.insert(cutsceneList[n].facing, npcs[i].start)
        end
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
        keyInput = 1
      end
    else
      cutsceneControl.stage = 5
    end
  else
    cutsceneControl.stage = 5
  end
end

--set conditions for screen fade, or skip to stage 7 if no fade
function cutsceneStage5Talk()
  print("cutscene stage 4")
  if cutsceneList[cutsceneControl.current].fadeout ~= 0 then
    fading.type = cutsceneList[cutsceneControl.current].fadeout
    fadeControl(fading.type)
    player.canMove = 0
    keyInput = 0
    fading.on = true
    cutsceneControl.stage = 6
  else
    player.canMove = 1
    cutsceneControl.stage = 7
  end
end

--run fade
function cutsceneStage6Talk(dt)
  if fading.on == true then
    fading.a, fading.on = fade(dt, fading.a, fading.goal, fading.rate)
  else
    cutsceneControl.stage = 7
  end
end

--advance to next stage
function cutsceneStage7Talk()
  print("stage 7 triggered")
  clearMap(2)
  if cutsceneList[cutsceneControl.current].triggered == false then
    if cutsceneList[cutsceneControl.current].nextStage == true then
      changeGameStage()
    end
    cutsceneList[cutsceneControl.current].triggered = true
  end
  if cutsceneControl.current < cutsceneControl.total then -- if there are more cutscenes advance to next one
    print("cutsceneControl.current less than total")
    if cutsceneList[cutsceneControl.current].skipnext == true then
      print("skipping to next cutscene")
      cutsceneControl.stage = 1
    else
      cutsceneControl.stage = 0
    end
    cutsceneControl.current = cutsceneList[cutsceneControl.current].next
  else
    cutsceneControl.stage = 8
  end
end

function changeGameStage()
  local n = cutsceneControl.current
  workStage = cutsceneList[cutsceneControl.current].workStage
  if cutsceneList[n].nextStage == true then
    if cutsceneList[cutsceneControl.current].switchTime ~= 0 then
      changeTime(cutsceneList[cutsceneControl.current].switchTime)
    end
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
      if npcs[i].next[gameStage].location ~= "offscreen" then
        if npcs[i].next[gameStage].x ~= 0 then
          npcs[i].grid_x = npcs[i].next[gameStage].x
          npcs[i].act_x = npcs[i].next[gameStage].x
        end
        if npcs[i].next[gameStage].y ~= 0 then
          npcs[i].grid_y = npcs[i].next[gameStage].y
          npcs[i].act_y = npcs[i].next[gameStage].y
        end
        if npcs[i].next[gameStage].facing ~= 0 then
          npcs[i].facing = npcs[i].next[gameStage].facing
          npcs[i].start = npcs[i].facing
        end
      end
      npcs[i].location = npcs[i].next[gameStage].location
      npcs[i].canWork = npcs[i].next[gameStage].canWork
      npcs[i].working = 0
      npcs[i].c = 1
      npcs[i].n = 1
      npcs[i].canMove = 0
      for j = 1, #player.party do
        if npcs[i].name == player.party[j] then
          npcs[i].canMove = 1
        end
      end
      makeObjectsInvisible(nonInteractiveObjects, "dininghall", "stool")
      -- npcs[i].actions.key = 0
      -- npcs[i].actions.index = 0
      npcActSetup()
      for k, v in pairs(movingObjectData) do
        for l, w in pairs(movingObjectData[k]) do
          for m = 1, #movingObjectData[k][l] do
            movingObjectData[k][l][m].running = 0
            movingObjectData[k][l][m].used = 0
          end
        end
      end
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



function workStageUpdate(dt)
  --breakfast, before entering field
  if workStage == 1 then
    sleepCheck(false)
    if currentLocation == "overworld" and areaCheck(17, 21, 17, 22, player) then
      workStage = 2
    end
  --after entering field
  elseif workStage == 2 then
    sleepCheck(false)
    if tempBlocks["overworld"][1].on == 0 and currentLocation == "overworld" then
      tempBlocks["overworld"][1].on = 1
      addTempBlocks(initTable)
			saveMap()
    end
  --can leave field
  elseif workStage == 3 then
		local i = getCharIndex("Finch")
		if objectInventory.barrelSmBerries + objectInventory.barrelLgBerries >= player.quota then
			if currentLocation == "overworld" and areaCheck(16, 21, 17, 22, player) then
				local bool1, k = checkInventory("plantSmBerries")
				local bool2, k = checkInventory("plantLgBerries")
        --if there are no berries in the player's inventory
				if bool1 == false and bool2 == false then
					if npcs[i].c ~= 3 then
						removeTempBlocks(currentLocation, 1)
            keyInput = 1
						npcs[i].c = 3
            print("gameStage " .. gameStage)
					end
          if gameStage == 4 then
            player.canMove = 0
            if dialogueMode == 0 and cutsceneControl.stage == 0 then
              cutsceneControl.stage = 1
            end
          end
				else
					if npcs[i].c ~= 4 then
            tempBlocks["overworld"][1].on = 1
            addTempBlocks(initTable)
						npcs[i].c = 4
						print("npcs[i].c " ..  npcs[i].c)
					end
				end
			end
		end
	elseif workStage == 4 then
		if tempBlocks.overworld[2].on == 0 then
			closeGates()
		end
    if time == 1 then
      sleepCheck(false)
    end
	end
end

function changeTime(t)
  time = t
  if time == 1 then
    clearTempBlocks()
    resetBerries()
    resetBarrels()
    day = day + 1
  end
  print("time " .. time)
end



function fadeControl(t) -- arg: fading.type
  if t == 1 then
    fading.start = 0
    fading.goal = 255
    fading.rate = 180
    fading.a = fading.start
  elseif t == 2 then
    fading.start = 255
    fading.goal = 0
    fading.rate = 140
    fading.a = fading.start
  elseif t == 3 then
    fading.start = 255
    fading.goal = 255
    fading.rate = 180
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
      cutsceneControl.stage = 7
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
      cutsceneControl.stage = 7
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

function runCutscene(dt)
  --cutscene triggered, update map
	if cutsceneControl.stage == 1 then
		cutsceneStage1Talk()
	end

	--cutsecene running, move characters
	if cutsceneControl.stage == 2 then
		 cutsceneStage2Talk(dt)
	end

	--cutscene running, trigger dialogue
	if cutsceneControl.stage == 3 then
		cutsceneStage3Talk()
	end

	--cutscene running, return to starting position
	if cutsceneControl.stage == 4 and dialogueMode == 0 then
		cutsceneStage4Talk(dt)
	end

	-- start fade out
	if cutsceneControl.stage == 5 then
		cutsceneStage5Talk()
	end

-- waiting for fade to finish
	if cutsceneControl.stage == 6 then
		cutsceneStage6Talk(dt)

	end

	--cutscene over, reset
	if cutsceneControl.stage == 7 and dialogueMode == 0 then
		cutsceneStage7Talk()
	end
end

-- function addJournal(a, b) -- entry
-- 	table.insert(currentJournal, journalText[a][b])
-- end

function makeObjectsInvisible(tbl, l, o)
  for i = 1, #npcs do
    for k = 1, #tbl[l][o] do
      if npcs[i].location == l then
        if npcs[i].grid_x == tbl[l][o][k].x and npcs[i].grid_y == tbl[l][o][k].y then
          tbl[l][o][k].visible = 0
        end
      end
    end
  end
end
