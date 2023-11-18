extends CanvasLayer

#++
# This is the Game Control UI script for the StartScreen scene.
#
# The only thing this script does is declare signals for each of the
# buttons on the screen, and provides functions Godot will run when the
# player clicks one of those buttons.
#
#--

signal startGame
signal showCredits
signal showDemoPage

func _ready():
	MCP.connect("fadeTheUI", fadeTheUI)
	
func fadeTheUI():
	print("fadeTheUI called")
	$VBoxContainer/AnimationPlayer.play("FadeToBlack")

func _on_start_game_pressed():
	startGame.emit()
	
func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	showCredits.emit()

func _on_demo_pressed():
	showDemoPage.emit()
