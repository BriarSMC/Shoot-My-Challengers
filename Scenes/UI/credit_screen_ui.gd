extends CanvasLayer

#++
# This is the Game Control UI script for the WinScreen scene.
#
# The only thing this script does is declare signals for each of the
# buttons on the screen, and provides functions Godot will run when the
# player clicks one of those buttons.
#
#--

signal backToStart

func _ready():
	MCP.connect("fadeTheUI", fadeTheUI)
	
func fadeTheUI():
	print("fadeTheUI called")
	$VBoxContainer/AnimationPlayer.play("FadeToBlack")

func _on_back_pressed():
	backToStart.emit()
