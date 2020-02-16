
function changeCharStats(char, stat1, stat2, amount)
	print("changing stats")
	local i = getCharIndex(char)
	if npcs[i].stats[stat1] ~= nil then
		if npcs[i].stats[stat1][stat2] ~= nil then
			npcs[i].stats[stat1][stat2] = npcs[i].stats[stat1][stat2] + amount
			print(char .. " stat " .. stat1 .. " changed by " .. amount)
			print("current stat: " .. npcs[i].stats[stat1][stat2])
		else
			print("stat2 is nil")
		end
	else
		print("stat1 is nil")
	end
end

function table_print (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    for key, value in pairs (tt) do
      io.write(string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        io.write(string.format("[%s] => table\n", tostring (key)));
        io.write(string.rep (" ", indent+4)) -- indent it
        io.write("(\n");
        table_print (value, indent + 7, done)
        io.write(string.rep (" ", indent+4)) -- indent it
        io.write(")\n");
      else
        io.write(string.format("[%s] => %s\n",
            tostring (key), tostring(value)))
      end
    end
  else
    io.write(tt .. "\n")
  end
end

function changeTrust(char1, char2, amount)
	local k = 0
	for i = 1, #trustTable do
		if trustTable[1][i] == char1 then
			k = i
		else
			print("char1 not found")
		end
	end
	for j = 1, #trustTable do
		if trustTable[j][1] == char2 then
			trustTable[j][k] = trustTable[j][k] + amount
		end
	end
	table_print(trustTable)
end

--initiate dialogue if char enters a certain square
function DialogueTrigger(x1, y1, f)
	if math.abs(player.act_x - x1*gridsize) < 0.1 and math.abs(player.act_y - y1*gridsize) < 0.1 then
		player.act_x = x1*gridsize
		player.act_y = y1*gridsize
		player.facing = f
		DialogueSetup(npcs, dialogueStage)
		trigger[1] = 1
		keyInput = 0
	end
end

function inputWait(n, dt)
	if n > 0 then
		if textn >= n then
			keyInput = 1
			wait.current = 0
			wait.triggered = 0
			wait.n = 0
			return
		else
			keyInput = 0
			return
		end
	else
		if wait.current > 0 then
			wait.current = wait.current - wait.rate*dt
			if keyInput == 1 then
				keyInput = 0
				return
			end
		else
			keyInput = 1
			wait.current = 0
			wait.triggered = 0
		end
	end
end

function timerBlink(dt, i)
	if timer[i].current > 0 then
		timer[i].current = timer[i].current - dt
	else
		if timer[i].trigger == 0 then
			timer[i].trigger = 1
		else
		 timer[i].trigger = 0
		end
		timer[i].current = timer[i].base
	end
end

function timerText(dt, i)
	timer[i].current = timer[i].current + dt
	while timer[i].current > timer[i].base do
	 textn = textn + 1
	 timer[i].current = timer[i].current - timer[i].base
	end
end

function getCharIndex(name)
	for i = 1, #npcs do
		if npcs[i].name == name then
			return i
		end
	end
	print("no character found in getCharIndex")
end

function checkAdjacent(char)
	if currentLocation == char.location then
		if player.act_y == char.act_y then
			if player.act_x == char.act_x - gridsize then
				return true
			elseif player.act_x == char.act_x + gridsize then
				return true
			end
		end
		if player.act_x == char.act_x then
			if player.act_y == char.act_y - gridsize then
				return true
			elseif player.act_y == char.act_y + gridsize then
				return true
			end
		end
	end
return false
end


--initiate dialogue
function initDialogue (char)
	local x = char.act_x
	local y = char.act_y
	if currentLocation == char.location then
		if char.offset ~= nil then
			if char.offset.location == currentLocation then
				x = x + char.offset.x
				y = y + char.offset.y
			end
		end
		if checkParty(char) == false then
			if player.act_y == y then
				if player.act_x == x - gridsize and player.facing == 4 then
					char.dialogue = 1
					char.facing = 3
					return true
				elseif player.act_x == x + gridsize and player.facing == 3 then
					char.dialogue = 1
					char.facing = 4
					return true
				end
			end
			if player.act_x == x then
				if player.act_y == y - gridsize and player.facing == 2 then
					char.dialogue = 1
					char.facing = 1
					return true
				elseif player.act_y == y + gridsize and player.facing == 1 then
					char.dialogue = 1
					char.facing = 2
					return true
				end
			end
		end
	end
char.dialogue = 0
return false
end


function textUpdate(num, currentTbl)
	dialogueMode = 1
	player.canMove = 0
	text = currentTbl.text[num]
	wait.n = string.len(currentTbl.text[num])
end

--dialogue off
function dialogueOff(tbl, i, dialOpt) -- tbl = npcs
	if dialOpt.logic.spoken == 0 then
		print("not spoken")
		if dialOpt.logic.energy ~= nil then
			if player.energy > 0 then
				player.energy = player.energy - 1
			end
		end
		if dialOpt.logic.func ~= nil then
			print("function not nil")
			dialOpt.logic.func(unpack(dialOpt.logic.par))
			print("function finished")
			dialOpt.logic.spoken = 1
			tbl[i].mapping.dialogueCount = tbl[i].mapping.dialogueCount + 1
			return
		end
		dialOpt.logic.spoken = 1
		tbl[i].mapping.dialogueCount = tbl[i].mapping.dialogueCount + 1
	end
	print("dialogueOff triggered")
	resetDialogue(tbl, i)
end

function resetDialogue(tbl, i)
	local dialOpt = NPCdialogue[gameStage][tbl[i].name][tbl[i].c]
	sfx.textSelect:play()
	choice.pos = 1
	choice.more = 0
	dialogueMode = 0
	player.canMove = 1
	tbl[i].n = 1
	tbl[i].c = dialOpt.logic.next
	tbl[i].dialogue = 0
	tbl[i].facing = tbl[i].start
	wait.triggered = 0
	storedIndex[1] = 0
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

function choiceChange(key, tbl)
	if key == "down" then
		if choice.pos >= 1 and choice.pos < choice.total then
			choice.pos = choice.pos + 1
			sfx.textSelect:play()
			print("choice.pos d " .. choice.pos)
		end
	elseif key == "up" then
		if choice.pos > 1 then
			choice.pos = choice.pos - 1
			sfx.textSelect:play()
			print("choice.pos u " .. choice.pos)
		end
	end
	choiceText(tbl, choice.pos, choice.total)
end

function DialogueSetup(tbl, n, index) -- iterate through npcs table, lookup text in NPCdialogue
	if index then
		dialogueRun(tbl, n, index, true)
	else
		for i = 1, #tbl do
			if initDialogue(tbl[i]) == true then
				print("initDialogue true")
				dialogueRun(tbl, n, i)
			end
		end
	end
end

function dialogueRun(tbl, n, i, r)
	local name = tbl[i].name
	local num = tbl[i].n
	local case = tbl[i].c
	if NPCdialogue[n][name] ~= nil then
		print("NPCdialogue[n][name] ~= nil")
		local dialOpt = NPCdialogue[n][name][case]
		local canSpeak = 1
		-- if freeze.dialogue == 1 then
		-- 	if dialOpt.logic.energy ~= nil then
		-- 		canSpeak = 0
		-- 		dialogueFreeze(tbl[i])
		-- 	end
		-- end
		if canSpeak == 1 then
			print("tbl[i].n " .. tbl[i].n)
			wait.triggered = 1
			currentspeaker = dialOpt.logic.speaker
			if tbl[i].mapping.added == 0 then
				tbl[i].mapping.added = 1
				table.insert(socialMap, tbl[i])
			end
			if dialOpt.logic.cond == true then
				if dialOpt.logic.display == 1 then
					if num <= #dialOpt.text then -- if there are more lines to say, advance through table
						print("advance " .. num .. #dialOpt.text)
						textUpdate(num, dialOpt)
						if num > 1 then
							sfx.textSelect:play()
						end
						tbl[i].n = num + 1
						print("tbl[i].n " .. tbl[i].n)
						print("dialogueMode " .. dialogueMode)
						if r then
							storedIndex[1] = i
						else
							return
						end
					else -- if not then move to next segment
						print("turnning off dialogue")
						if dialOpt.logic.off == true then
							dialogueOff(tbl, i, dialOpt)
							return
						else
							if dialOpt.logic.spoken ~= nil and dialOpt.logic.spoken == 0 then
								if dialOpt.logic.trustmod ~= nil then
									print("trustmod not nil")
									changeTrust(unpack(dialOpt.logic.statpar))
								end
								if dialOpt.logic.func ~= nil then
									dialOpt.logic.func(unpack(dialOpt.logic.par))
								end
								dialOpt.logic.spoken = 1
								tbl[i].mapping.dialogueCount = tbl[i].mapping.dialogueCount + 1
							end
							tbl[i].n = 1
							tbl[i].c = dialOpt.logic.next
							sfx.textSelect:play()
							if r then
								DialogueSetup(tbl, n, i)
							else
								DialogueSetup(tbl, n)
							end
						end
					end
				end
				if dialOpt.logic.display == 2 then
					print("triggered choice display")
					if choice.mode == 0 then -- if choice has not been made yet
						wait.current = wait.start
						choice.mode = 1
						choice.total = #dialOpt.text
						choice.name = name
						choice.case = case
						choiceText(dialOpt.text, choice.pos, choice.total) -- display dialogue options
						choice.type = "npc"
						return
					elseif choice.mode == 1 then
						sfx.textSelect:play()
						print("choice mode off case" .. case)
						local o = dialOpt.logic.offset
						dialOpt.logic.spoken = 1
						dialOpt.logic.next = choice.pos + o
						tbl[i].n = 1
						tbl[i].c = dialOpt.logic.next
						choice.mode = 0
						choice.pos = 1
						if r then
							DialogueSetup(tbl, n, i)
						else
							DialogueSetup(tbl, n)
						end
					end
				end
			end
		end
	end
end

function dialogueFreeze(tbl)
	if dialogueMode == 0 then
		tbl.facing = tbl.start
		tbl.dialogue = 0
		wait.triggered = 1
		dialogueMode = 1
		player.canMove = 0
		currentspeaker = "player"
		text = "I'm too tired to talk."
	else
		print("dialogueFreeze set dialogueMode to 0")
		tbl.facing = tbl.start
		tbl.dialogue = 0
		dialogueMode = 0
		player.canMove = 1
	end
end
-- check if all chars spoken to
function checkSpoken(tbl1, tbl2, num) -- npcs, NPCdialogue[stage]
	local count = 0
	for i = 1, #tbl1 do
		local name = tbl1[i].name
		if tbl2[name] ~= nil then
			for k = 1, #tbl2[name] do
				if tbl2[name][k].logic.spoken == 1 then
					if tbl2[name][k].logic.off == true then
						count = count + 1
					end
				end
			end
		end
	end
	if count < num then
		return false
	else
		return true
	end
end

function changeDialogue(npc, n)
	local i = getCharIndex(npc)
	print("Change dialogue for " .. npc)
	npcs[i].c = n
end

function changeDialogueNext(type, stage, npc, i, n, par)
	if type == "inventory" then
		if checkInventory(par) == false then
			NPCdialogue[stage][npc][i].logic.next = n
		end
	elseif type == "gateclosed" then
		if nonInteractiveObjects.overworld.fenceclosedL[1].visible == 1 then -- gate closed
			NPCdialogue[stage][npc][i].logic.next = n
		end
	elseif type == "spoken" then
		if checkLineSpoken(par[1], par[2], par[3]) == true then -- stage name c
			NPCdialogue[stage][npc][i].logic.next = n
		end
	end
	if NPCdialogue[stage][npc][i].logic.off == true then
		local j = getCharIndex(npc)
		resetDialogue(npcs, j)
	end
end

-- function addInfo(txt, name)
-- 	local i = getCharIndex(name)
-- 	npcs[i].info.notes = npcs[i].info.notes .. " " .. txt
-- 	resetDialogue(npcs, i)
-- end


function quitGame(t)
  print("restarting")
  love.event.quit(t)
end

function addParty(char)
	local added = checkParty(char)
	if added == false then
		local j = getCharIndex(char)
		npcs[j].canMove = 1
		npcs[j].canWork = 0
		npcs[j].working = 0
		table.insert(player.party, char)
		print(char.." added to party")
		print(#player.party)
		resetDialogue(npcs, j)
	end
end

function checkParty(char)
	for i = 1, #player.party do
		if player.party[i] == char then
			return true
		end
	end
	return false
end

function removeParty(char)
	for i = 1, #player.party do
		print(player.party[i])
		if player.party[i] == char then
			print("removing from party " .. player.party[i])
			player.party[i] = nil
			table.remove(player.party, i)
		end
	end
end

function changeQuota(n, name)
	local i = getCharIndex(name)
	player.quota = n
	resetDialogue(npcs, i)
end

function updateUI (element, b, name)
	local i = getCharIndex(name)
	uiSwitches[element] = b
	if element == "bedArrow" and b == true then
		sleepCheck(true)
	end
	resetDialogue(npcs, i)
end

function changeMoney(c, s, g)
	player.money.current.c = player.money.current.c + c
	player.money.current.s = player.money.current.s + s
	player.money.current.g = player.money.current.g + g
end

function changeVar(v, tbl, n, i, ...) -- v = variable to change to, n = number of nested tables, i = key
	if n == 2 then
		tbl[i] = v
		print("variable changed to " .. v .. " n = 2")
		checkReset()
	elseif n == 3 then
		tbl[i][arg[1]] = v
		print("variable changed to " .. v .. " n = 3")
		checkReset()
	end
end

function checkReset()
	for i = 1, #npcs do
		if npcs[i].dialogue == 1 then
			print("dialogue is 1")
			local n = dialogueStage
			local name = npcs[i].name
			local c = npcs[i].c
			if NPCdialogue[n][name][c].logic.off == true then
				print("reset dialogue")
				resetDialogue(npcs, i)
			end
		end
	end
end

function checkLineSpoken(n, name, c)
	if NPCdialogue[n][name][c].logic.spoken == true then
		return true
	else
		return false
	end
end
