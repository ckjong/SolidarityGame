function battleStart()
  positionChars(player.grid_x, player.grid_y, player.party, npcs)
end

function createArena(x, y)

end

function positionChars(x, y, party, tbl) --player.grid_x, player.grid_y, player.party
  x = x + 2 * gridsize
  y = y - (2*(#party-1)) * gridsize
  for i = 1, #party do
    local j = party[i]
    tbl[j].start = player.facing
    tbl[j].grid_x = x
    tbl[j].grid_y = y
    tbl[j].act_x = x
    tbl[j].act_y = y
    y = y + 2*gridsize
  end
end

function changeSelection(num) -- if battleGlobal.phase == 1
  if key == "right" then
    num = num + 1
  elseif key == "left" then
    num = num - 1
  end
  local tbl = selectChar(num)
  return tbl
end

function selectChar(num)
  if num == 1 then
    return player
  else
    local i =  player.party[num]
    return npcs[i]
  end
end
