extends GameControlScreen
class_name WinScreen

#++
# This defines the lose control screen displayed when the player
# wins the game.
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

	
#+
# Class specific methods
#-

# _ready()
# Called when object is ready
#
# Parameters
#	None
# Return 
#	None
#==
# Set the background image for the parent class
func _ready() -> void:
	super._ready()
	
# Temp to exit the scene for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


#++
# Signal callbacks
#--

# _on_win_screen_ai_continue_game()
# Captures the signal from the UI for the Win Screen when the
# player wants to continue to the Start Screen
#
# Paramters
#	None
# Return 
#	None
#==
# Start the animation player for FadeToBlack. This animation player will
# call our goToNextScreen() method.
func _on_win_screen_ui_continue_game():
	MCP.fadeTheUI.emit()
	$Sprite2D/AnimationPlayer.play("FadeToBlack")
