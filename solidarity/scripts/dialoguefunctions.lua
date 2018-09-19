

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


function DialogueSetup (tbl, n) -- iterate through npcs table, lookup text in NPCdialogue
	for i = 1, #tbl do
		if initDialogue(tbl[i]) == true then
			local name = tbl[i].name
			local num = tbl[i].n
			local case = tbl[i].c
			local dialOpt = NPCdialogue[n][name][case]
			if dialOpt.logic.cond == true then
				if dialOpt.logic.display == 1 then
					if num <= #dialOpt.text then -- if there are more lines to say, advance through table
						textUpdate(num, dialOpt)
						tbl[i].n = num + 1
						return
					else -- if not then move to next segment
						print("num > dialogue lines " .. tbl[i].n)
						if dialOpt.logic.off == true then
							if dialOpt.logic.spoken ~= nil then
								dialOpt.logic.spoken = 1
							end
							dialogueOff(tbl, i, dialOpt.logic.next)
							return
						else
							tbl[i].n = 1
							tbl[i].c = dialOpt.logic.next
							DialogueSetup (tbl, n)
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
						textUpdate (choice.pos, NPCdialogue[n][name][case]) -- display response
						if dialOpt.logic.trigger ~= nil then
							if dialOpt.logic.trigger.choice == choice.pos then
								if dialOpt.logic.trigger.type == "battle" then
									battleMode = 1
									choice.mode = 0
									tbl[i].c = dialOpt.logic.next
									if dialOpt.logic.spoken ~= nil then
										dialOpt.logic.spoken = 1
									end
									dialogueOff(tbl, i, dialOpt.logic.next)
									--change location to battlefield if battleMode active and dialogue finished
									-- battleMap(battleMode, dialogueMode)
									return
								end
							end
						end
						choice.mode = 0
						tbl[i].c = dialOpt.logic.next
						return
					else
						if dialOpt.logic.off == true then
							if dialOpt.logic.spoken ~= nil then
								dialOpt.logic.spoken = 1
							end
							dialogueOff(tbl, i, dialOpt.logic.next)
						else
							tbl[i].n = 1
							tbl[i].c = dialOpt.logic.next
							DialogueSetup (tbl, n)
						end
					end
				end
			end
		end
	end
end

-- check if all chars spoken to
function checkSpoken(tbl1, tbl2, num) -- npcs, NPCdialogue[stage]
	local count = 0
	for i = 1, #tbl1 do
		local name = tbl1[i].name
		for k = 1, #tbl2[name] do
			if tbl2[name][k].logic.spoken == 1 then
				count = count + 1
			end
		end
	end
	if count < num then
		return false
	else
		return true
	end
end
