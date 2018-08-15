refPos = {}
local posMoves = {0, 0, 0, 0}

function getRef(x, y)
  refPos[1] = x
  refPos[2] = y
end

function setPosMoves(x, y) -- player.grid_x, player.grid_y
  if testMap(x, y, 0, -1) then
    posMoves[1] = 1
  end
  if testMap(x, y, 0, 1) then
    posMoves[2] = 1
  end
  if testMap(x, y, -1, 0) then
    posMoves[3] = 1
  end
  if testMap(x, y, 1, 0) then
    posMoves[4] = 1
  end
end

function pickTarget(posMoves, x, y)
  for i = 1, #posMoves do
    if posMoves[i] == 1 then
      refPos[1] 
    end
  end
end
