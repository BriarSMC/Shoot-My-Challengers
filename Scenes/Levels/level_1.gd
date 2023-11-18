extends Node2D
class_name Level1

#++
# This is the Level 1 scene
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

func _ready() -> void:
	Globals.scaleMe($PlayingArea, scaleFactor)		# Adjust how big we are
	
#+
# Class specific methods
#-

# Temp to exit the scene for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_W: $AnimationPlayer.play("FadeToBlackWin")
			KEY_L: $AnimationPlayer.play("FadeToBlackLose")
		
		
# goToNextScreen()
# This method loads the next screen. 
#
# HUGE NOTE: The end of $Sprite2D/AnimationPlayer needs to call this method
#
# Paramters
#	nextLevel: int				The next level to go to 
# Return 
#	None
#==
# Call the MCP to change over to the next screen		
func goToNextScreen(nextLevel: int):
	MCP.changeGameState(nextLevel)
