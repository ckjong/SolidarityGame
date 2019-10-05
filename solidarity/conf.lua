-- Configuration
function love.conf(t)
	t.title = "Solidarity" -- The title of the window the game is in (string)
	t.version = "0.10.2"         -- The LÖVE version this game was made for (string)
	t.window.width = 960
	t.window.height = 720
	t.window.resizable = false
	t.window.vsync = 1

	-- For Windows debugging
	t.console = false
end
