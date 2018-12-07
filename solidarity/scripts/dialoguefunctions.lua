

--initiate dialogue if char enters a certain square
function DialogueTrigger(x1, y1, f)
	if (player.act_x - x1*gridsize) < 0.02 and (player.act_y - y1*gridsize) < 0.02 then
		player.act_x = x1*gridsize
		player.act_y = y1*gridsize
		player.facing = f
		DialogueSetup(npcs, dialogueStage)
		trigger[1] = 1
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


function textUpdate(num, currentTbl)
	print("textUpdate triggered")
	dialogueMode = 1
	player.canMove = 0
	text = currentTbl.text[num]
	wait.n = string.len(currentTbl.text[num])
end

--dialogue off
function dialogueOff(tbl, i, dialOpt) -- tbl = npcs
	if dialOpt.logic.spoken == 0 then
		if dialOpt.logic.energy ~= nil then
			if player.energy > 0 then
				player.energy = player.energy - 1
			end
		end
		if dialOpt.logic.func ~= nil then
			dialOpt.logic.func(unpack(dialOpt.logic.par))
			dialOpt.logic.spoken = 1
			return
		end
		dialOpt.logic.spoken = 1
	end
	print("dialogueOff triggered")
	choice.more = 0
	dialogueMode = 0
	player.canMove = 1
	tbl[i].n = 1
	tbl[i].c = dialOpt.logic.next
	tbl[i].dialogue = 0
	wait.triggered = 0
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

function choiceChange(key)
	if key == "down" then
		if choice.pos >= 1 and choice.pos < choice.total then
			choice.pos = choice.pos + 1
		end
	elseif key == "up" then
		if choice.pos > 1 then
			choice.pos = choice.pos - 1
		end
	end
	choiceText(NPCdialogue[dialogueStage][choice.name][choice.case].text, choice.pos, choice.total)
end

function DialogueSetup(tbl, n) -- iterate through npcs table, lookup text in NPCdialogue
	for i = 1, #tbl do
		if initDialogue(tbl[i]) == true then
			if freeze.dialogue == 1 then
				dialogueFreeze(tbl[i])
			elseif freeze.dialogue == 0 then
				print("tbl[i].n " .. tbl[i].n)
				wait.triggered = 1
				local name = tbl[i].name
				local num = tbl[i].n
				local case = tbl[i].c
				local dialOpt = NPCdialogue[n][name][case]
				currentspeaker = dialOpt.logic.speaker
				if dialOpt.logic.cond == true then
					if dialOpt.logic.display == 1 then
						if num <= #dialOpt.text then -- if there are more lines to say, advance through table
							print("advance " .. num .. #dialOpt.text)
							textUpdate(num, dialOpt)
							tbl[i].n = num + 1
							print("tbl[i].n " .. tbl[i].n)
							return
						else -- if not then move to next segment
							if dialOpt.logic.off == true then
								dialogueOff(tbl, i, dialOpt)
								return
							else
								tbl[i].n = 1
								tbl[i].c = dialOpt.logic.next
								DialogueSetup(tbl, n)
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
							return
						elseif choice.mode == 1 then
							print("choice mode off case" .. case)
							local o = dialOpt.logic.offset
							dialOpt.logic.spoken = 1
							dialOpt.logic.next = choice.pos + o
							tbl[i].n = 1
							tbl[i].c = dialOpt.logic.next
							choice.mode = 0
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
		tbl.dialogue = 0
		wait.triggered = 1
		dialogueMode = 1
		player.canMove = 0
		currentspeaker = "player"
		text = "I'm too tired to talk."
	else
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
					count = count + 1
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

function charGivesObject(a, b, c, d, e)
	print("character gives object")
	currentspeaker = "player"
	addRemoveItem(a, b, c, d, e)
	return
end
