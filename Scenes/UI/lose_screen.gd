extends GameControlScreen
class_name LoseScreen

# This defines the lose control screen displayed when the player
# loses the game.

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal callbacks

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
# signal the next screen to show.
func _on_lose_screen_ai_continue_game():
	$LoseScreenAI.fadeUI()
	$Sprite2D/AnimationPlayer.play("FadeToBlack")
