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
signal fadeTheUI

func _ready():
	connect("fadeTheUI", fadeUI)
	
func fadeUI():
	print("fadeUI called")
	$VBoxContainer/AnimationPlayer.play("FadeToBlack")

func _on_back_pressed():
	backToStart.emit()
