local function createNode(x, y)
  return { x = x, y = y, h = 0, g = 0, f = 0 }
end

local pathfinding = {}
pathfinding.mapData = {}

function pathfinding.initMap(gameMap)
  local w, h = #gameMap[1], #gameMap -- gameMap width and height dimensions
  pathfinding.map = gameMap
  for y = 1, h do pathfinding.mapData[y] = {}
    for x = 1, w do
      pathfinding.mapData[y][x] = createNode(x,y)
    end
  end
end

function pathfinding.isWalkable(x, y)
  return pathfinding.map[y] and pathfinding.map[y][x] == 0
end

-- Direction vectors for orthogonal neighbors
local orthogonalVectors = {
  {x =  0, y = -1},
  {x = -1, y =  0},
  {x =  1, y =  0},
  {x =  0, y =  1},
}

-- Direction vectors for diagonal neighbors
local diagonalVectors = {
  {x = -1, y = -1},
  {x =  1, y = -1},
  {x = -1, y =  1},
  {x =  1, y =  1}
}

-- This returns the appropriate nodeData struct:
function pathfinding.getNode(x, y)
  return pathfinding.mapData[y] and pathfinding.mapData[y][x]
end

-- Returns an array of neighbors of node n
function pathfinding.getNeighbors(n, diagonal)
  local neighbors = {}
  for _, axis in ipairs(orthogonalVectors) do
    local x, y = n.x + axis.x, n.y + axis.y
    if pathfinding.isWalkable(x, y) then  -- Only include the orthogonal neighbor if it is walkable
      table.insert(neighbors, pathfinding.getNode(x, y))
    end
  end
  if diagonal then
    for _, axis in ipairs(diagonalVectors) do
      local x, y = n.x + axis.x, n.y + axis.y
      if pathfinding.isWalkable(x, y) then -- Only include the diagonal neighbor if it is walkable
      table.insert(neighbors, pathfinding.getNode(x, y))
      end
    end
  end
  return neighbors
end

local function manhattan(nodeA, nodeB)
  local dx, dy = nodeA.x - nodeB.x, nodeA.y - nodeB.y
  return math.abs(dx) + math.abs(dy)
end

local function euclidian(nodeA, nodeB)
  local dx, dy = nodeA.x - nodeB.x, nodeA.y - nodeB.y
  return math.sqrt(math.abs(dx*dx) + math.abs(dy*dy))
end


pathfinding.openList = {}
pathfinding.visited = {}


local function resetForNextSearch(pathfinding)
  for node in pairs(pathfinding.visited) do
    node.parent, node.opened, node.closed = nil, nil, nil  -- erases some temporary properties added during the search
    node.f, node.g, node.h = 0, 0, 0 -- resets all the costs back to zero
  end
  pathfinding.openList = {} -- clears the openList
  pathfinding.visited = {} -- clears the visited nodes list
end

local function backtrace(node)
  local path = {}
  repeat
    table.insert(path, 1, node)
    node = node.parent
  until not node
  return path
end

--CORE FUNCTION--
function pathfinding.findPath(startX, startY, goalX, goalY, diagonal)
  local startNode = pathfinding.getNode(startX, startY)  -- get the startNode data
  local goalNode = pathfinding.getNode(goalX, goalY) -- get the startNode data
  assert(startNode, ('Invalid coordinates for startNode: (%d, %d)'):format(startX, startY))
  assert(goalNode, ('Invalid coordinates for goalNode: (%d, %d)'):format(goalX, goalY))
  resetForNextSearch(pathfinding)  -- clears node data, explained before

  -- pushes the start node to the openList
  startNode.g = 0
  startNode.h = manhattan(startNode, goalNode)
  startNode.f = startNode.g + startNode.h
  table.insert(pathfinding.openList, startNode)
  pathfinding.visited[startNode] = true -- adds the startNode to the list of visited nodes.

  while #pathfinding.openList ~= 0 do   -- while there are still some nodes in the openList
    -- We pops the node at the head of the list, it should be the lowest f-cost node normally
    local node = pathfinding.openList[1]
    table.remove(pathfinding.openList, 1)

    -- if this node is the goal, we stop and backtrace to get the path
    if node == goalNode then return backtrace(node) end

    -- if not, we move it to the closed list, and we examine its neigbors.
    node.closed = true
    local neighbors = pathfinding.getNeighbors(node, diagonal) -- we can add an extra argument here if we need diagonals, see before.
    for _, neighbor in ipairs(neighbors) do
      if not neighbor.closed then       -- if the neighbor was not examined before, try to see if it can lead to a better path
        local tentative_g = node.g + manhattan(node, neighbor)
        if not neighbor.opened or tentative_g < neighbor.g then -- If so, set the actual node as the parent of the neighbor, and update data
          neighbor.parent = node
          neighbor.g = tentative_g
          neighbor.h = manhattan(neighbor, goalNode)
          neighbor.f = neighbor.g + neighbor.h
          pathfinding.visited[neighbor] = true -- add the neighbor to the list of visited node, since its data were mdified
          if not neighbor.opened then  -- push the neighbor to the openList as it was not already there
            neighbor.opened = true
            table.insert(pathfinding.openList, neighbor)
          end

           -- since we made some edits to the node data, we need to sort the openList by f-cost
          table.sort(pathfinding.openList, function(nodeA, nodeB) return nodeA.f < nodeB.f end)

        end
      end
    end
  end
end


-- The game map
-- local gameMap = initTable
-- create pathfinding map data
-- pathfinding.initMap(gameMap)
-- local path = pathfinding.findPath(10,29, 18,25) -- Looks for path from node(1,1) to node(5,3) without diagonals.
-- -- if found, then print the steps along the path
-- if path then
--   for k, node in ipairs(path) do print(node.x, node.y) end
-- end
function removeFlagged(path)
  for k, node in ipairs(path) do
    if math.abs(node.x-(player.grid_x/gridsize)) > 8 or math.abs(node.y-(player.grid_y/gridsize)) > 8 then
      print("removing " .. node.x, node.y)
      table.remove(path, k)
      return true, path
    end
  end
  return false, path
end

function createPathNPC(x1, y1, x2, y2)
  print(x1, y1, x2, y2)
  local gameMap = initTable
  pathfinding.initMap(gameMap)
  local path = pathfinding.findPath(x1, y1, x2, y2)
  if path then
    local r = true
    while r == true do
      r, path = removeFlagged(path)
    end
    return path
  end
end
