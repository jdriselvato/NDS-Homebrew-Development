dofile("/lua/libs/shellFunc.lua")
local Dir = "/lua/scripts"
shell.init()

while true do
	
	Controls.read()
	shell.show()
	render()
	shell.held()
end
