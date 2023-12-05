extends Weapon
class_name Laser

# Defines the Laser for the Skull of Death

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal Callbacks

func _on_body_entered(body):
	if body.is_in_group("Hero"):
		body.takeDamage(damage)

	queue_free()
