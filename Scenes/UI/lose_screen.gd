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

# goToNextScreen()
# This method loads the next screen. 
#
# HUGE NOTE: The end of $Sprite2D/AnimationPlayer needs to call this method
#
# Paramters
#	paramname: type				Description
# Return 
#	value|None					Description
#==
# Call the MCP to change over to the next screen			
func goToNextScreen() -> void:
	MCP.changeGameState(MCP.state.START)

# _on_lose_screen_ai_continue_game()
# Captures the signal from the UI for the Lose Screen when the
# player wants to continue to the Start Screen
#
# Paramters
#	None
# Return 
#	None
#==
# Start the animation player for FadeToBlack. This animation player will
# call our goToNextScreen() method.
func _on_lose_screen_ai_continue_game():
	$Sprite2D/AnimationPlayer.play("FadeToBlack")
