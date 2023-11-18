extends Node2D

func _ready():
	Globals.positionUIImage(self)
	
func _process(_delta):
	Globals.positionUIImage(self)
# Temp to exit the scene for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func goToNextScene() -> void:
	print('going to START')
	MCP.changeGameState(MCP.state.START)
	
