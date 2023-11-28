extends CanvasLayer

# This is the Game Control UI script for the CreditScreen scene.
#
# The only thing this script does is declare signals for each of the
# buttons on the screen, and provides functions Godot will run when the
# player clicks one of those buttons.
#
# When we exit this screen for another we run the FadeToBlack animation to dim the screen.
# Godot won't let us modulate the StartScreenUI. So we have to call the fadeUI() method 
# in StartScreenUI.

# Signals
signal backButtonClicked

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods
	
func fadeUI():
	print("fadeUI called")
	$VBoxContainer/AnimationPlayer.play("FadeToBlack")

# Signal Callbacks

func _on_back_pressed():
	print('Credit Screen Back clicked')
	backButtonClicked.emit()
