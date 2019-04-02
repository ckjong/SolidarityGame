function getScale()
  local baseW = 260
  local baseH = 180
  local windowW = love.graphics.getWidth()
  local windowH = love.graphics.getHeight()
  local scalex = math.floor(windowW/baseW)
  local scaley = math.floor(windowH/baseH)
  if scalex < scaley then
    scalex = scaley
  elseif scaley < scalex then
    scaley = scalex
  end
  return scalex, scaley

end

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

--control npc act animations

function npcActSetup()
  for i = 1, #npcs do
    npcs[i].facing = npcs[i].start
    if npcs[i].canWork == 1 then
      math.randomseed(i)
      local a = math.random(2, 6)
      local b = math.random(4, 12)
      npcs[i].timer.mt = a
      npcs[i].timer.wt = b
      print(npcs[i].name .. " mt " .. npcs[i].timer.mt)
      print(npcs[i].name .. " wt " .. npcs[i].timer.wt)
    end
  end
end

function npcActUpdate(dt, i)
  if npcs[i].canWork == 1 then
    npcs[i].timer.ct = npcs[i].timer.ct + dt
    if npcs[i].working == 1 then
      if npcs[i].timer.ct >= npcs[i].timer.mt then
        npcs[i].timer.ct = 0
        npcs[i].working = 0
        npcs[i].actions.on = 0
        if npcs[i].animations.act[npcs[i].facing].running == 1 then
          npcs[i].animations.act[npcs[i].facing].running = 0
          -- print(npcs[i].name .. " animation turned off " .. player.animations.act[npcs[i].facing].running)
        end
      end
    else
      if npcs[i].timer.ct >= npcs[i].timer.wt then
        npcs[i].timer.ct = 0
        npcs[i].working = 1
        npcs[i].animations.act[npcs[i].facing].running = 1
          -- print(npcs[i].name .. " npc animation running " .. npcs[i].animations.act[npcs[i].facing].running)
      end
    end
  end
end

function setTintColor(t)
  if t == 1 then
    love.graphics.setColor(255, 255, 255)
  elseif t == 2 then
    if currentLocation == "overworld" then
	    love.graphics.setColor(255, 180, 180)
    else
      love.graphics.setColor(255, 255, 255)
    end
  end
end


--draw background
function drawBackground()
  love.graphics.setBackgroundColor(93, 43, 67)
  setTintColor(time)
	love.graphics.draw(currentBackground, 16, 16)
end

-- --render dialogue box
-- function drawBox(boxposx, boxposy, recwidth, recheight)
--   love.graphics.setColor(75, 37, 58)
--   love.graphics.rectangle("fill", boxposx, boxposy, recwidth, recheight, 4, 4, 4) -- outside box (dark)
--   love.graphics.setColor(255, 221, 163)
--   love.graphics.rectangle("fill", boxposx+2, boxposy+2, recwidth-4, recheight-4, 3, 3, 4) -- inside box (light colored)
-- end

function animUpdate(tbl, dt, k)
  if k then
    tbl[k]["anim"]["currentTime"] = tbl[k]["anim"]["currentTime"] + dt
    if tbl[k]["anim"]["currentTime"] >= tbl[k]["anim"]["duration"] then
      tbl[k]["anim"]["currentTime"] = tbl[k]["anim"]["currentTime"] - tbl[k]["anim"]["duration"]
      if tbl[k].loop ~= 0 then
        tbl[k].count = tbl[k].count + 1
        if tbl[k].count == tbl[k].loop then
          resetAnims(tbl, k)
          -- if actionMode == 0 then
          --   animFinish()
          -- end
        end
      end
    end
  else
    for k, v in pairs(tbl) do
  		tbl[k]["anim"]["currentTime"] = tbl[k]["anim"]["currentTime"] + dt
      if tbl[k]["anim"]["currentTime"] >= tbl[k]["anim"]["duration"] then
        tbl[k]["anim"]["currentTime"] = tbl[k]["anim"]["currentTime"] - tbl[k]["anim"]["duration"]
        if tbl[k].loop ~= 0 then
          tbl[k].count = tbl[k].count + 1
          if tbl[k].count == tbl[k].loop then
            print("count:" .. tbl[k].count)
            resetAnims(tbl, k)
            -- if actionMode == 0 then
            --   animFinish()
            -- end
          end
        end
      end
  	end
  end
end
--
-- function animFinish()
--   player.actions.key = 0
--   player.actions.index = 0
-- end

function resetAnims(tbl, k)
  if tbl[k].running == 1 then
    tbl[k].running = 0
    tbl[k].count = 0
    if tbl[k].trigger ~= nil then
      if tbl[k].trigger == 1 then
        tbl[k].anim = newAnimation(animsheet2, tbl[k].picked*16, 3, 16, 16, .3)
        tbl[k].trigger = 0
      elseif tbl[k].trigger == 2 then
        tbl[k].anim = newAnimation(animsheet2, (tbl[k].picked+4)*16, 3, 16, 16, .3)
        tbl[k].trigger = 0
      elseif tbl[k].trigger == 3 then
        tbl[k]["anim"]["spriteSheet"] = animsheet3
				tbl[k]["anim"]["quads"] = {movingObjectQuads.plantSm}
        tbl[k].trigger = 0
				table.insert(movingObjectData[currentLocation].plantSm, tbl[k])
				table.remove(tbl, k)
      elseif tbl[k].trigger == 4 then
        tbl[k]["anim"]["spriteSheet"] = animsheet3
        tbl[k]["anim"]["quads"] = {movingObjectQuads.plantLg}
        tbl[k].trigger = 0
        table.insert(movingObjectData[currentLocation].plantLg, tbl[k])
        table.remove(tbl, k)
      end
    end
  end
end



--render portrait
function drawPortrait(name, x, y, sheet)
  local quad = portraitkey[name]
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(sheet, quad, x + 4, y-16)
end

--render player
function drawPlayer(tbl)
  local i = player.moveDir
  setTintColor(time)
  if player.moveDir ~= 0 then
    local spriteNum = math.floor(tbl[i]["anim"]["currentTime"] / tbl[i]["anim"]["duration"] * #tbl[i]["anim"]["quads"]) + 1
    if spriteNum > 4 then
      spriteNum = 4
    elseif spriteNum < 1 then
      spriteNum = 1
    end
    love.graphics.draw(tbl[i]["anim"]["spriteSheet"], tbl[i]["anim"]["quads"][spriteNum], player.act_x, player.act_y, 0, 1)
  elseif player.moveDir == 0 then
    i = player.facing
    if player.animations.act[i].running == 0 then
      love.graphics.draw(tbl[i]["anim"]["spriteSheet"], tbl[i]["anim"]["quads"][1], player.act_x, player.act_y, 0, 1)
    else
      drawActAnims(player.animations.act, player.facing, player.act_x, player.act_y)
    end
  end
end

function drawNPCs(tbl, i)
  setTintColor(time)
  if currentLocation == npcs[i].location then
    local j = npcs[i].moveDir
    local f = npcs[i].facing
    local s = npcs[i].start
    if npcs[i].dialogue == 1 then
      love.graphics.draw(tbl[f]["anim"]["spriteSheet"], tbl[f]["anim"]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
    else
      if npcs[i].canMove == 1 then
        if npcs[i].moveDir ~= 0 then
          local spriteNum = math.floor(tbl[j]["anim"]["currentTime"] / tbl[j]["anim"]["duration"] * #tbl[j]["anim"]["quads"]) + 1
          if spriteNum > 4 then
            spriteNum = 4
          elseif spriteNum < 1 then
            spriteNum = 1
          end
          love.graphics.draw(tbl[j]["anim"]["spriteSheet"], tbl[j]["anim"]["quads"][spriteNum], npcs[i].act_x, npcs[i].act_y, 0, 1)
        elseif npcs[i].moveDir == 0 then
          love.graphics.draw(tbl[f]["anim"]["spriteSheet"], tbl[f]["anim"]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
        end
      else
        if npcs[i].working == 1 then
          drawActAnims(npcs[i].animations.act, f, npcs[i].act_x, npcs[i].act_y)

        else
          tbl = npcs[i].animations.walk
          love.graphics.draw(tbl[s]["anim"]["spriteSheet"], tbl[s]["anim"]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
        end
      end
    end
  end
end

function drawStillObjects(l, tbl, img, quad)
  setTintColor(time)
  if tbl[l] ~= nil then
    for k, v in pairs(tbl[l]) do
      for i = 1, #tbl[l][k] do
        if tbl[l][k][i].visible == 1 then
          love.graphics.draw(img, quad[k], tbl[l][k][i].x, tbl[l][k][i].y)
        end
      end
    end
  end
end

function drawActAnims(tbl, k, x, y)
  setTintColor(time)
  if tbl[k].running == 1 then
    local spriteNum = math.floor(tbl[k]["anim"]["currentTime"] / tbl[k]["anim"]["duration"] * #tbl[k]["anim"]["quads"]) + 1
    if tbl[k]["anim"]["quads"][spriteNum] ~= nil then
      love.graphics.draw(tbl[k]["anim"]["spriteSheet"], tbl[k]["anim"]["quads"][spriteNum], x, y, 0, 1)
    else
      local n = 1
      if spriteNum > #tbl[k]["anim"]["quads"] then
        n = #tbl[k]["anim"]["quads"]
      end
      love.graphics.draw(tbl[k]["anim"]["spriteSheet"], tbl[k]["anim"]["quads"][n], x, y, 0, 1)
    end
  elseif tbl[k].running == 0 then
    love.graphics.draw(tbl[k]["anim"]["spriteSheet"], tbl[k]["anim"]["quads"][1], x, y, 0, 1)
  end
end

function drawMeters(x, y)
  love.graphics.setColor(255, 255, 255)
  -- love.graphics.draw(ui.energytextbgsmleft, x, y)
  love.graphics.draw(uiSheet, uiQuads.energyiconcircle, x, y)
  love.graphics.draw(uiSheet, uiQuads.energytextbground, x+gridsize+1, y+1)
  love.graphics.setColor(75, 37, 58)
  love.graphics.printf(player.energy, x + gridsize+2, y+5, 16, "center")
end

function drawTime(x, y)
  local txt = ""
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(uiSheet, uiQuads.energytextbgsmleft, x, y+1)
  love.graphics.draw(uiSheet, uiQuads.energytextbgsmright, x+gridsize, y+1)
  love.graphics.setColor(75, 37, 58)
  love.graphics.printf("Day " .. day, x, y+5, 32, "center")
  love.graphics.setColor(255, 255, 255)
  if time == 1 then
    love.graphics.draw(uiSheet, uiQuads.timeiconday, x - 16, y)
  elseif time == 2 then
    love.graphics.draw(uiSheet, uiQuads.timeiconevening, x - 16, y)
  elseif time == 3 then
    love.graphics.draw(uiSheet, uiQuads.timeiconnight, x - 16, y)
  end
end

function drawBubble(x, y, obj)
  if obj == "barrelSmBerries" or obj == "barrelLgBerries" then
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(uiSheet, uiQuads.speechbubblemedbot, x, y)
    love.graphics.setColor(75, 37, 58)
    love.graphics.printf(objectInventory[obj], x, y+4, 16, "center")
  end
end

function drawName(boxposx, boxposy)
  local nameposx = boxposx + 48
  local nameposy = boxposy - 12
  local l = string.len(currentspeaker)
  if currentspeaker == "player" then
    l = string.len(player.name)
  end
  local n = 16
  if l < 5 then
    n = 6
  elseif l >= 5 and l < 7 then
    n = 10
  elseif l >= 7 then
    n = 16
  end
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(uiSheet, uiQuads.namebgL, nameposx, nameposy)
  love.graphics.draw(uiSheet, uiQuads.namebgM, nameposx + n, nameposy)
  love.graphics.draw(uiSheet, uiQuads.namebgR, nameposx + 2 * n, nameposy)
  love.graphics.setColor(75, 37, 58)
  if currentspeaker ~= "player" then
    love.graphics.printf(currentspeaker, nameposx, nameposy+4, n+n+17, "center")
  else
    love.graphics.printf(player.name, nameposx, nameposy+4, n+n+17, "center")
  end
end

function drawText(x, y, scalex, recwidth)
  local width = love.graphics.getWidth( )/scalex
  local c = text:sub(1, textn)
  if choice.mode == 1 then
    love.graphics.setColor(255, 255, 255)
    if choice.total == 2 then
      y = y + 4
    end
    if choice.pos == 1 then
        love.graphics.draw(ui.arrowright, x, y-3)
    elseif choice.pos < choice.total then
      love.graphics.draw(ui.arrowright, x, y + 5)
    elseif choice.pos == choice.total then
      if choice.total == 2 then
        love.graphics.draw(ui.arrowright, x, y + 5)
      else
        love.graphics.draw(ui.arrowright, x, y + 13)
      end
    end
    love.graphics.setColor(75, 37, 58)
    love.graphics.printf(c, x+6, y-3, recwidth - 60)
  else
    love.graphics.setColor(75, 37, 58)
    love.graphics.printf(c, x, y, recwidth - 66) -- 48, 46, 112
  end
end


function drawArrow(x, y, scaley, recwidth)
  local height = (love.graphics.getHeight( )/scaley)/2 - 6
  if timer[1].trigger == 1 then
    love.graphics.setColor(255, 255, 255)
    if choice.mode == 1 then
      if choice.pos < choice.total then
        love.graphics.draw(ui.arrowdown, x + recwidth - 12, player.act_y + height)
      end
      if choice.pos > 1 then
        love.graphics.draw(ui.arrowup, x + recwidth - 12, player.act_y + height - 20)
      end
    else
      love.graphics.draw(ui.pressz, x + recwidth - 12, player.act_y + height)
    end
  end
end

function drawInfo(x, y)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill",  x - 54, y - 54, 68, 32 )
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(currentLocation, x - 48, y - 48)
  love.graphics.print("x: " .. x/gridsize .." y: " .. y/gridsize, x - 48, y - 40)
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), x - 48, y - 30)
end

function drawMenu(x, y, tab)
  local menuText = ""
  local offset = {x= 106, y = 56}
  local boxX = x + gridsize/2 - menuW/2
  local textW = menuW
  local textX = x + gridsize/2 - textW/2
  local textY = y-offset.y+6
  local width, height = love.graphics.getDimensions()
  love.graphics.setColor(198, 200, 84)
  love.graphics.rectangle("fill", x - width/2, y - height/2, width, height)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(canvas, boxX, y-offset.y)
  if tab == "inventory" then
    menuText = drawInventory(x, y, offset.x - 14, offset.y - 22)
  elseif tab == "journal" then
    menuText = "Journal"
  elseif tab == "map1" then
    menuText = "Social Map"
  elseif tab == "map2" then
    menuText = "Island Map"
    drawMap2(x + gridsize/2, y-offset.y +16)
  end
  if menu.position[1] == 1 then
    if timer[1].trigger == 1 then
      love.graphics.setColor(255, 255, 255)
      love.graphics.draw(ui.arrowleft, boxX+32, textY)
      love.graphics.draw(ui.arrowright, boxX + menuW - 32, textY)
    end
  end
  love.graphics.setColor(75, 37, 58)
  love.graphics.printf(menuText, boxX, textY, textW, "center")
end


local function drawMenuBottom(x, y, offX, offY)
  local i = menu.position[2]
  local selectText = ""
  local descriptionText = ""
  if #player.inventory > 0 then
    local k = player.inventory[i].icon
    local textposx = x + gridsize/2 - menuW/2
    local textposy = y - offY + menuH
    local n = 16
    selectText = player.inventory[i].item
    if itemDescription[k] ~= nil then
      descriptionText = itemDescription[k]
    else
      print("no item description found")
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(uiSheet, uiQuads.namebgL, textposx + 80, textposy - 68)
    love.graphics.draw(uiSheet, uiQuads.namebgM, textposx + 80 + n, textposy - 68)
    love.graphics.draw(uiSheet, uiQuads.namebgM, textposx + 80 + 2 * n, textposy - 68)
    love.graphics.draw(uiSheet, uiQuads.namebgR, textposx + 80 + 3 * n, textposy - 68)
    love.graphics.setColor(75, 37, 58)
    love.graphics.printf(selectText, textposx, textposy - 64, menuW, "center")
    love.graphics.printf(descriptionText, textposx +4, textposy - 46, menuW - 6, "center")
  end
end

function drawInventory(x, y, offX, offY)
  local txt = "Inventory"
  local items = {}
  local objText = ""
  local selectText = ""
  local descriptionText = ""
  for i = 1, player.maxInventory do
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(uiSheet, uiQuads.itembg, x - offX + (i-1)*(26), y - offY)
  end
  for i = 1, #player.inventory do
    local n = player.inventory[i].icon
    if i > 8 then
      offY = offY - 24
    end
    love.graphics.setColor(75, 37, 58)
    love.graphics.rectangle("line",  x - offX + (i-1)*(26), y - offY, 16, 16)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(animsheet3, movingObjectQuads[n], x - offX + (i-1)*(26), y - offY)
    objText = tostring(player.inventory[i].amount)
    love.graphics.setColor(75, 37, 58)
    love.graphics.printf(objText, x - offX + (i-1)*(26), y - offY + 18, 16, "center")
  end
  if menu.position[1] == 2 then
    local i = menu.position[2]
    if #player.inventory > 0 then
      drawMenuBottom(x, y, offX, offY)
    end
    if timer[1].trigger == 1 then
      love.graphics.setColor(255, 255, 255)
      love.graphics.draw(ui.cornerLTop, x - offX - 4 + (i-1)*(26), y - offY - 4)
      love.graphics.draw(ui.cornerRTop, x - offX + gridsize + (i-1)*(26), y - offY - 4)
      love.graphics.draw(ui.cornerLBottom, x - offX - 4 + (i-1)*(26), y - offY + gridsize)
      love.graphics.draw(ui.cornerRBottom, x - offX + gridsize + (i-1)*(26), y - offY + gridsize)
    end
  elseif menu.position[1] == 3 then
    local i = menu.position[2]
    local a = 0
    local b = 0
    local width, height = love.graphics.getDimensions()
    local recheight = 32
		local recwidth = 232
		local xnudge = width/2
		local ynudge = 1*scale.y
		local boxposx = player.act_x + gridsize/2 - recwidth/2
		local boxposy = player.act_y + gridsize/2 + (height/scale.y)/2 - recheight - ynudge
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(ui.cornerLTop, x - offX - 4 + (i-1)*(26), y - offY - 4)
    love.graphics.draw(ui.cornerRTop, x - offX + gridsize + (i-1)*(26), y - offY - 4)
    love.graphics.draw(ui.cornerLBottom, x - offX - 4 + (i-1)*(26), y - offY + gridsize)
    love.graphics.draw(ui.cornerRBottom, x - offX + gridsize + (i-1)*(26), y - offY + gridsize)
    if #player.inventory > 0 then
      drawMenuBottom(x, y, offX, offY)
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(ui.textboxbg, boxposx, boxposy)
    love.graphics.draw(ui.textboxbottom, boxposx, boxposy)
    if menu.position[3] == 1 then
      love.graphics.draw(ui.arrowright, boxposx + 8, boxposy + 8)
      a = 6
    elseif menu.position[3] == 2 then
      love.graphics.draw(ui.arrowright, boxposx + 8, boxposy + 16)
      b = 6
    end
    love.graphics.setColor(75, 37, 58)
    love.graphics.print("Use", boxposx + 8 + a, boxposy + 8)
    love.graphics.print("Drop", boxposx + 8 + b, boxposy + 16)
  end
  return txt
end


function drawMap2(x, y)
  local width = worldmap1:getWidth( )
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(worldmap1, x - width/2, y)
end

function fadeBlack(alpha, width, height)
  love.graphics.setColor(75, 37, 58, alpha)
  love.graphics.rectangle("fill", player.act_x-width/2, player.act_y-height/2, width, height)
end
