--animation
function newAnimation(image, start, length, width, height, duration)
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};
	for y = start, start, height do
    for x = 0, length * width - width, width do
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
		tbl[k][1]["currentTime"] = tbl[k][1]["currentTime"] + dt
    if tbl[k][1]["currentTime"] >= tbl[k][1]["duration"] then
        tbl[k][1]["currentTime"] = tbl[k][1]["currentTime"] - tbl[k][1]["duration"]
    end
	end
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
      local spriteNum = math.floor(tbl[i][1]["currentTime"] / tbl[i][1]["duration"] * #tbl[i][1]["quads"]) + 1
      love.graphics.draw(tbl[i][1]["spriteSheet"], tbl[i][1]["quads"][spriteNum], player.act_x, player.act_y, 0, 1)
    elseif player.moveDir == 0 then
      if player.facing == i then
        love.graphics.draw(tbl[i][1]["spriteSheet"], tbl[i][1]["quads"][1], player.act_x, player.act_y, 0, 1)
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
        love.graphics.draw(tbl[k+f][1]["spriteSheet"], tbl[k+f][1]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
      else
        if npcs[i].canMove == 1 then
          for v = 1, 4 do
            if npcs[i].moveDir == v then
              local spriteNum = math.floor(tbl[k+j][1]["currentTime"] / tbl[k+j][1]["duration"] * #tbl[k+j][1]["quads"]) + 1
              love.graphics.draw(tbl[k+j][1]["spriteSheet"], tbl[k+j][1]["quads"][spriteNum], npcs[i].act_x, npcs[i].act_y, 0, 1)
            elseif npcs[i].moveDir == 0 then
              if npcs[i].facing == v then
                love.graphics.draw(tbl[k+f][1]["spriteSheet"], tbl[k+f][1]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
              end
            end
          end
        else
          love.graphics.draw(tbl[k+s][1]["spriteSheet"], tbl[k+s][1]["quads"][1], npcs[i].act_x, npcs[i].act_y, 0, 1)
        end
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
        love.graphics.draw(ui.arrowright, x, y-4)
    elseif choice.pos < choice.total then
      love.graphics.draw(ui.arrowright, x, y + 4)
    elseif choice.pos == choice.total then
      love.graphics.draw(ui.arrowright, x, y + 12)
    end
    love.graphics.setColor(93, 43, 67)
    love.graphics.printf(text, x+6, y-4, width - 72)
  else
    love.graphics.setColor(93, 43, 67)
    love.graphics.printf(text, x, y, width - 66) -- 48, 46, 112
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

--change alpha to fade out or in image, delta time, alpha, goal, rate
function fade(dt, a, b, r)
  if r > 0 then -- alpha going up
    if a <= b then
      a = a + r*dt
      print("alpha " .. a)
      return a, true
    else
      player.canMove = 1
      keyInput = 1
      print("fading off")
      cutsceneControl.stage = 7
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
      cutsceneControl.stage = 7
      return a, false
    end
  end
end

function fadeBlack(alpha, width, height)
  print("fadeBlack alpha " .. alpha)
  love.graphics.setColor(50, 29, 62, alpha)
  love.graphics.rectangle("fill", player.act_x-width/2, player.act_y-height/2, width, height)
end

function screenBlack(width, height) -- render a black square over the screen
  love.graphics.setColor(50, 29, 62, 255)
  love.graphics.rectangle("fill", player.act_x-width/2, player.act_y-height/2, width, height)
end
