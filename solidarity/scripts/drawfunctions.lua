--form box
function formBox(w, h)
  if w >= 32 and h >= 32 then
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(255, 255, 255)
    local xTiles = math.floor(w/16)
    local yTiles = math.floor(h/16)
    for k = 1, yTiles do
      for i = 1, xTiles do
        if i == 1 then
          if k == 1 then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[1][1], 0, 0)
            table.insert(boxMap, {1,1})
          elseif k > 1 and k < yTiles then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[2][1], 0, (k-1)*16)
            table.insert(boxMap, {2,1})
          elseif k == yTiles then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[3][1], 0, (k-1)*16)
            table.insert(boxMap, {3,1})
          end
        elseif i > 1 and i < xTiles then
          if k == 1 then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[1][2], (i-1)*16, 0)
            table.insert(boxMap, {1,2})
          elseif k > 1 and k < yTiles then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[2][2], (i-1)*16, (k-1)*16)
            table.insert(boxMap, {2,2})
          elseif k == yTiles then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[3][2], (i-1)*16, (k-1)*16)
            table.insert(boxMap, {3,2})
          end
        elseif i == xTiles then
          if k == 1 then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[1][3], (i-1)*16, (k-1)*16)
            table.insert(boxMap, {1,3})
          elseif k > 1 and k < yTiles then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[2][3], (i-1)*16, (k-1)*16)
            table.insert(boxMap, {2,3})
          elseif k == yTiles then
            love.graphics.draw(boxTilesSheet, boxTilesQuads.fill[3][3], (i-1)*16, (k-1)*16)
            table.insert(boxMap, {3,3})
          end
        end
      end
    end
    love.graphics.setCanvas()
  else
    print("box not big enough")
  end
end

function drawCustomBox(x, y, tbl)
  for i = 1, #boxMap do
    local k = boxMap[i][1]
    local v = boxMap[i][2]
    love.graphics.draw(boxTilesSheet, boxTilesQuads[k][v], x)
  end
end

--animation
function newAnimation(image, start, length, width, height, duration, startx)
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};
	for y = start, start, height do
    for x = startx or 0, length * width - width, width do
      table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  end
  animation.duration = duration or 1
  animation.currentTime = 0
  return animation
end

--draw background
function drawBackground()
  love.graphics.setBackgroundColor(93, 43, 67)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(currentBackground, 16, 16)
end

-- --render dialogue box
-- function drawBox(boxposx, boxposy, recwidth, recheight)
--   love.graphics.setColor(93, 43, 67)
--   love.graphics.rectangle("fill", boxposx, boxposy, recwidth, recheight, 4, 4, 4) -- outside box (dark)
--   love.graphics.setColor(255, 221, 163)
--   love.graphics.rectangle("fill", boxposx+2, boxposy+2, recwidth-4, recheight-4, 3, 3, 4) -- inside box (light colored)
-- end

function animUpdate(tbl, dt)
  for k, v in pairs(tbl) do
		tbl[k]["anim"]["currentTime"] = tbl[k]["anim"]["currentTime"] + dt
    if tbl[k]["anim"]["currentTime"] >= tbl[k]["anim"]["duration"] then
      tbl[k]["anim"]["currentTime"] = tbl[k]["anim"]["currentTime"] - tbl[k]["anim"]["duration"]
      tbl[k].running = 0
      -- if tbl[k].loop ~= 0 then
      --   if tbl[k].running == 1 then
      --     if tbl[k].current > 0 then
      --       print("tbl[k].current " .. tbl[k].current)
      --       tbl[k].current = tbl[k].current - 1
      --     else
      --       tbl[k].current = tbl[k].loop
      --       tbl[k].running = 0
      --     end
      --   end
      -- end
    end
	end
end

function resetAnims(tbl, k)
  print("reset triggered")
  tbl[k].running = 1
end

--render portrait
function drawPortrait(name, x, y, sheet)
  local k = 0
  for i = 1, #portraitkey do
    if name == portraitkey[i].name then
      k =  i
    end
  end
  local image = sheet
  local s = portraitkey[k].start
  local w = portraitkey[k].width
  local h = portraitkey[k].height
  local quad = love.graphics.newQuad(s, 0, w, h, image:getDimensions())
  love.graphics.draw(sheet, quad, x + 4, y-16)
end

--render player
function drawPlayer(tbl)
  for i = 1, 4 do
    if player.moveDir == i then
      local spriteNum = math.floor(tbl[i]["anim"]["currentTime"] / tbl[i]["anim"]["duration"] * #tbl[i]["anim"]["quads"]) + 1
      love.graphics.draw(tbl[i]["anim"]["spriteSheet"], tbl[i]["anim"]["quads"][spriteNum], player.act_x, player.act_y, 0, 1)
    elseif player.moveDir == 0 then
      if player.facing == i then
        if actionMode == 0 then
          love.graphics.draw(tbl[i]["anim"]["spriteSheet"], tbl[i]["anim"]["quads"][1], player.act_x, player.act_y, 0, 1)
        end
      end
    end
  end
end

function drawNPCs(tbl)
  for i = 1, #npcs do
    if currentLocation == npcs[i].location then
      local j = npcs[i].moveDir-1
      local k = npcs[i].animationkey
      local f = npcs[i].facing-1
      local s = npcs[i].start-1
      if npcs[i].dialogue == 1 then
        love.graphics.draw(tbl[k+f]["anim"]["spriteSheet"], tbl[k+f]["anim"]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
      else
        if npcs[i].canMove == 1 then
          for v = 1, 4 do
            if npcs[i].moveDir == v then
              local spriteNum = math.floor(tbl[k+j]["anim"]["currentTime"] / tbl[k+j]["anim"]["duration"] * #tbl[k+j]["anim"]["quads"]) + 1
              love.graphics.draw(tbl[k+j]["anim"]["spriteSheet"], tbl[k+j]["anim"]["quads"][spriteNum], npcs[i].act_x, npcs[i].act_y, 0, 1)
            elseif npcs[i].moveDir == 0 then
              if npcs[i].facing == v then
                love.graphics.draw(tbl[k+f]["anim"]["spriteSheet"], tbl[k+f]["anim"]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
              end
            end
          end
        else
          love.graphics.draw(tbl[k+s]["anim"]["spriteSheet"], tbl[k+s]["anim"]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
        end
      end
    end
  end
end

function drawTop(l, tbl, img, quad)
  if tbl[l] ~= nil then
    for i = 1, #tbl[l] do
      local k = tbl[l][i][1]
      if tbl[l][i][4] == 1 then
        love.graphics.draw(img, quad[k], tbl[l][i][2], tbl[l][i][3])
      end
    end
  end
end

function drawActAnims(tbl, k, x, y)
  local spriteNum = math.floor(tbl[k]["anim"]["currentTime"] / tbl[k]["anim"]["duration"] * #tbl[k]["anim"]["quads"]) + 1
  if tbl[k].loop ~= 0 then
    if tbl[k].running == 1 then
      love.graphics.draw(tbl[k]["anim"]["spriteSheet"], tbl[k]["anim"]["quads"][spriteNum], x, y, 0, 1)
    elseif tbl[k].running == 0 then
      love.graphics.draw(tbl[k]["anim"]["spriteSheet"], tbl[k]["anim"]["quads"][1], x, y, 0, 1)
    end
  end
end

function drawMeters(x, y)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(ui.energytextbgsmleft, x, y)
  love.graphics.draw(ui.energytextbgcircle, x, y)
  love.graphics.draw(ui.energyboltsm, x, y)
  love.graphics.draw(ui.energytextbgsmright, x+gridsize, y)
  love.graphics.setColor(93, 43, 67)
  love.graphics.print(player.energy, x + gridsize, y+5)
end

function drawText(x, y)
  local width = love.graphics.getWidth( )/4
  local c = text:sub(1, textn)
  if choice.mode == 1 then
    love.graphics.setColor(255, 255, 255)
    if choice.pos == 1 then
        love.graphics.draw(ui.arrowright, x, y-4)
    elseif choice.pos < choice.total then
      love.graphics.draw(ui.arrowright, x, y + 4)
    elseif choice.pos == choice.total then
      if choice.total == 2 then
        love.graphics.draw(ui.arrowright, x, y + 4)
      else
        love.graphics.draw(ui.arrowright, x, y + 12)
      end
    end
    love.graphics.setColor(93, 43, 67)
    love.graphics.printf(c, x+6, y-4, width - 72)
  else
    love.graphics.setColor(93, 43, 67)
    love.graphics.printf(c, x, y, width - 66) -- 48, 46, 112
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

function drawInfo(x, y)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill",  x - 54, y - 54, 68, 32 )
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(currentLocation, x - 48, y - 48)
  love.graphics.print("x: " .. x/gridsize .." y: " .. y/gridsize, x - 48, y - 40)
end

function drawMenu(x, y)
  local menuText = ""
  local objectText = ""
  local items = {}
  local offset = {x= 106, y = 56}
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(canvas, player.act_x-offset.x, player.act_y-offset.y)
  for i = 1, #player.inventory do
    local n = player.inventory[i].icon
    local objectText = ""
    love.graphics.setColor(93, 43, 67)
    love.graphics.rectangle("line",  x - offset.x + 6, y - offset.y + 18 + (i-1)*(28), 16, 16 )
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(movingObjectSheet, movingObjectQuads[n], x - offset.x + 6, y - offset.y + 18 + (i-1)*(28))
    objectText = tostring(player.inventory[i].amount .. " " .. player.inventory[i].item)
    love.graphics.setColor(93, 43, 67)
    love.graphics.print(objectText, x - offset.x + 6 , y - offset.y + 36 + (i-1)*(28))
  end
  if #player.inventory > 0 then
    menuText = "Inventory\n\n"
    objectText = table.concat(items, "\n\n\n", 1, #items)
  else
    menuText = "Inventory\n\nEmpty\n"
  end
  love.graphics.setColor(93, 43, 67)
  love.graphics.print(menuText, x -100, y - 48)
end

function fadeBlack(alpha, width, height)
  love.graphics.setColor(93, 43, 67, alpha)
  love.graphics.rectangle("fill", player.act_x-width/2, player.act_y-height/2, width, height)
end

function multiplyLayer(width, height)
  love.graphics.setColor(255, 255, 255, 80)
	love.graphics.setBlendMode("alpha")
	love.graphics.draw(overlays.evening, player.act_x-width/2, player.act_y-height/2)
  love.graphics.setBlendMode("alpha")
end
