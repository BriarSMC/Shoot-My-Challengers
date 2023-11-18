extends Node2D

#++
# <description>
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-
func _ready():
	Globals.positionUIImage(self)
	
func _process(_delta):
	Globals.positionUIImage(self)
# Temp to exit the scene for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
#+
# Class specific methods
#-


func goToNextScene() -> void:
	MCP.changeGameState(MCP.state.START)
	
