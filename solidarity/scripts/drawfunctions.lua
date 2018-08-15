--render dialogue box
function drawBox(boxposx, boxposy, recwidth, recheight)
  love.graphics.setColor(93, 43, 67)
  love.graphics.rectangle("fill", boxposx, boxposy, recwidth, recheight) -- outside box (dark)
  love.graphics.setColor(255, 247, 220)
  love.graphics.rectangle("fill", boxposx+2, boxposy+2, recwidth-4, recheight-4) -- inside box (light colored)
end

--render player
function drawPlayer()
  for i = 1, 4 do
    if player.moveDir == i then
      local spriteNum = math.floor(animations[i][1]["currentTime"] / animations[i][1]["duration"] * #animations[i][1]["quads"]) + 1
        love.graphics.draw(animations[i][1]["spriteSheet"], animations[i][1]["quads"][spriteNum], player.act_x, player.act_y, 0, 1)
    elseif player.moveDir == 0 then
      if player.facing == i then
        love.graphics.draw(animations[i][1]["spriteSheet"], animations[i][1]["quads"][1], player.act_x, player.act_y, 0, 1)
      end
    end
  end
end

function drawNPCs()
  for i = 1, #npcs do
    if currentLocation == npcs[i].location then
      local k = npcs[i].animationkey
      local f = npcs[i].facing-1
      local s = npcs[i].start-1
      if npcs[i].dialogue == 1 then
        love.graphics.draw(animations[k+f][1]["spriteSheet"], animations[k+f][1]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
      else
        love.graphics.draw(animations[k+s][1]["spriteSheet"], animations[k+s][1]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
      end
    end
  end
end

function drawTop(l, tbl)
  love.graphics.draw(toptiles[l], tbl[l][1][1], tbl[l][1][2])
end

function drawText(x, y)
  local width = love.graphics.getWidth( )/4
  if choice.mode == 1 then
    love.graphics.setColor(255, 255, 255)
    if choice.pos == 1 then
        love.graphics.draw(ui.arrowright, x, y)
    elseif choice.pos < choice.total then
      love.graphics.draw(ui.arrowright, x, y + 8)
    elseif choice.pos == choice.total then
      love.graphics.draw(ui.arrowright, x, y + 16)
    end
    love.graphics.setColor(93, 43, 67)
    love.graphics.printf(text, x+6, y, width - 8)
  else
    love.graphics.setColor(93, 43, 67)
    love.graphics.printf(text, x, y, width - 8) -- 48, 46, 112
  end
end


function drawArrow()
  local width = (love.graphics.getWidth( )/4)/2 - 8
  local height = (love.graphics.getHeight( )/4)/2 - 8
  if timer[1].trigger == 1 then
    love.graphics.setColor(255, 255, 255)
    if choice.more ~= 2 then
      love.graphics.draw(ui.pressz, player.act_x + width, player.act_y + height)
    else
      love.graphics.draw(ui.arrowdown, player.act_x + width, player.act_y + height)
    end
  end
end
