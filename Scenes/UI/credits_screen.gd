extends Node2D

func _ready():
	Globals.positionUIImage(self)

func _process(_delta):
	Globals.positionUIImage(self)

# Temp to exit the scene for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
		
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
func goToNextScreen():
	MCP.changeGameState(MCP.state.START)
		

# _on_credit_screen_ai_back_to_start_game()
# Captures the signal from the UI for the Credits Screen when the
# player wants to go back to the Start Screen
#
# Paramters
#	None
# Return 
#	None
#==
# Start the animation player for FadeToBlack. This animation player will
# call our goToNextScreen() method.
func _on_credit_screen_ui_back_to_start():
	$Sprite2D/AnimationPlayer.play("FadeToBlack")
