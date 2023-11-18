extends GameControlScreen
class_name CreditsScreen
#++
# This class defines the credits screen.
#
# The credits screen has two components:
#	* Scrolling text area
#	* A goback button
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

#+
# Signal callbacks
#-

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
