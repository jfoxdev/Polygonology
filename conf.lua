function love.conf(t)
	
	t.identity = "Polygonology"
	t.version = "0.10.0"

	t.modules.joystick = false
	t.modules.physics = true
	
	t.window.width = 1024
	t.window.height = 768
	t.window.borderless = false
	t.window.resizable = false
	t.window.minwidth = 1
	t.window.minheight = 1
	t.window.fullscreen = false
	t.window.fullscreentype = "desktop"
	t.window.vsync = true
	t.window.msaa = 0
	t.window.display = 1
	t.window.highdpi = false
	t.window.x = nil
	t.window.y = nil

end
