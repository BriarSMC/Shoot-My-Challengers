extends CanvasLayer

#++
# This is the Game Control UI script for the LoseScreen scene.
#
# The only thing this script does is declare signals for each of the
# buttons on the screen, and provides functions Godot will run when the
# player clicks one of those buttons.
#
#--

# Signals
signal continueGame
signal fadeTheUI

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Called when node is ready
#
# Parameters
#	None
# Return 
#	None
#==
# Set up handling the fade the UI signal
func _ready():
	connect("fadeTheUI", fadeUI)
	
# Class specific methods

func fadeUI():
	print("fadeUI called")
	$Container/AnimationPlayer.play("FadeToBlack")
	
# Signal Callbacks

func _on_continue_pressed():
	continueGame.emit()
