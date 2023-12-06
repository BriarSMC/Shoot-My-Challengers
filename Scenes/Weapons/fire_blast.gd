extends Weapon
class_name FireBlast

# This class defines the fire blast used by the Skull of Death

# Signals
signal fireBlastComplete

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal Callbacks

# Tell the Skull of Death the animation is finished
# so it can start the retreat
func _on_weapon_image_animation_finished():
		fireBlastComplete.emit()
