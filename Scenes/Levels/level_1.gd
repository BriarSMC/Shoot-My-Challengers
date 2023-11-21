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

# _ready()
# Called when the node is ready
#
# Parameters
#	None
# Return 
#	None
#==
# Scale the playing area images
# Tell the MCP what level is playing
func _ready() -> void:
	Globals.scaleMe($PlayingArea, scaleFactor)		# Adjust how big we are
	MCP.level = self

# Temp to exit the scene for debugging	
func _physics_process(_delta):
	checkKeyPressed()
#+
# Class specific methods
#-

# Temp to exit the scene for debugging
func checkKeyPressed() -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_key_pressed(KEY_W):
		$AnimationPlayer.play("FadeToBlackWin")
	if Input.is_key_pressed(KEY_L):
		$AnimationPlayer.play("FadeToBlackLose")
		
		
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
