extends Chest
class_name LargeChest

# This class defines the large chest container

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal callbacks

# Call the open if we were hit by Hero's Weapon
func _on_body_entered(body):
	if body.is_in_group("HeroWeapon"):
		openChest($AnimatedSprite2D)
