extends GameControlScreen
class_name CreditsScreen

# This class defines the credits screen.
#
# The credits screen has two components:
#	* Scrolling text area
#	* A goback button

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal callbacks

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
# signal what screen is next.
func _on_credit_screen_ui_back_to_start():
	$CreditScreenUI.fadeUI()
	$Sprite2D/AnimationPlayer.play("FadeToBlack")


# When the back button is clicked on our UI, then go back to the start screen
func _on_credit_screen_ui_back_button_clicked():
	changeGameScreen.emit(0,0)
