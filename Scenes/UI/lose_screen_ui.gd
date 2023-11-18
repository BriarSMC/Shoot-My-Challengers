extends CanvasLayer

#++
# This is the Game Control UI script for the LoseScreen scene.
#
# The only thing this script does is declare signals for each of the
# buttons on the screen, and provides functions Godot will run when the
# player clicks one of those buttons.
#
#--

signal continueGame

func _ready():
	MCP.connect("fadeTheUI", fadeTheUI)
	
func fadeTheUI():
	print("fadeTheUI called")
	$Container/AnimationPlayer.play("FadeToBlack")

func _on_continue_pressed():
	continueGame.emit()
