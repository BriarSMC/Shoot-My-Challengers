extends GameControlScreen
class_name StartScreen

# This defines the class for the Start Control Screen.
#
# SMC displays this screen immediately following the splash screen.
# It allows the player to:
#	* Start a new game
#	* Quit back to the O/S
#	* View the game credits
#
# Levels return to this screen after a win or loss.

# Signals

# Properties

# The following properties must be set in the Inspector by the designer	

# The following are set based on the Inspector values

# Virtual Godot methods

# _input(event)
# Called whenever an input happens
#
# Parameters
#	event						What event happened
# Return 
#	None
#==
# Quit the game is the player requests it
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
# Class specific methods


# Signal callbacks

# _on_start_screen_ai_start_game()
# Captures the signal from the UI for the Start Screen when the
# player wants to play the game. We change scenes to level 1.
#
# Paramters
#	None
# Return 
#	None
#==
# Start the animation player for FadeToBlack. This animation player will
# call our goToNextScreen() method.		
func _on_start_screen_ui_start_game():
#	fadeTheUI.emit()
	$Sprite2D/AnimationPlayer.play("FadeToBlack")


# _on_start_screen_ai_show_credits()
# Captures the signal from the UI for the Start Screen when the
# player wants to show the credits. We change scenes to level 1.
#
# Paramters
#	None
# Return 
#	None
#==
# Start the animation player for FadeToBlack. This animation player will
# call our goToNextScreen() method.		
func _on_start_screen_ui_show_credits():
#	fadeTheUI.emit()
	$Sprite2D/AnimationPlayer.play("FadeToBlackCredits")


# _on_start_screen_ai_show_demo_page()
# Captures the signal from the UI for the Start Screen when the
# player wants to show the credits. We change scenes to level 1.
#
# Paramters
#	None
# Return 
#	None
#==
# Start the animation player for FadeToBlack. This animation player will
# call our goToNextScreen() method.		
func _on_start_screen_ui_show_demo_page():
#	fadeTheUI.emit()
	$Sprite2D/AnimationPlayer.play("FadeToBlackDemo")
