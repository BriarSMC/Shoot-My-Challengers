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
func _ready():
	$Container/TextureRect.position.y += 200

func _process(delta):
	$Container/TextureRect.position.y -= 20 * delta

# Virtual Godot methods


# Class specific methods

func fadeUI():
	$VBoxContainer/AnimationPlayer.play("FadeToBlack")

# Signal Callbacks

func _on_back_pressed():
	SfxHandler.playSfx(SfxHandler.SFX.UIBUTTON)
	backButtonClicked.emit()


func _on_back_focus_entered():
	SfxHandler.playSfx(SfxHandler.SFX.UIBUTTONBLIP)
