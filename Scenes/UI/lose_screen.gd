extends GameControlScreen
class_name LoseScreen

#++
# This defines the lose control screen displayed when the player
# loses the game.
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
	mySprite2D = $Sprite2D
	super._ready()
		
# Temp to exit the scene for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
#+
# Class specific methods
#-


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
