extends GameControlScreen
class_name WinScreen

# This defines the lose control screen displayed when the player
# wins the game.

# Signals

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal callbacks

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
	$WinScreenUI.fadeUI()
	$Sprite2D/AnimationPlayer.play("FadeToBlack")
