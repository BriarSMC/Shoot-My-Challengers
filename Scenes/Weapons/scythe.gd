extends Weapon
class_name Scythe

# This class defines the Skeleton Grim Reaper's secondary weapon (Scythe)

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

func startAnimation() -> void:
	$AnimationPlayer.play("Swing")


# Signal Callbacks
