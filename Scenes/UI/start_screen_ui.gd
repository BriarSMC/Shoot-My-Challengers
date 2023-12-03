extends CanvasLayer

# This is the Game Control UI script for the StartScreen scene.
#
# This script does declares signals for each of the
# buttons on the screen, and provides functions Godot will run when the
# player clicks one of those buttons. It also defines a function to fade the UI
# elements.

# Signals

signal startGame
signal showCredits
signal showDemoPage


# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

func fadeUI():
	$VBoxContainer/AnimationPlayer.play("FadeToBlack")

# Signal callbacks

func _on_start_game_pressed():
	startGame.emit()

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	showCredits.emit()

func _on_demo_pressed():
	showDemoPage.emit()
