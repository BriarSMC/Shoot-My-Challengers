extends Weapon
class_name Knife

# This class defines the Skeleton Warrior's primary weapon (Knife)

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal Callbacks

# Deal damage if it's the Hero.
# Go away regardless
func _on_body_entered(body):
	if body.is_in_group("Hero"):
		body.takeDamage(damage)

	queue_free()
