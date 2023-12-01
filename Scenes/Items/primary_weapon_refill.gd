extends Item
class_name PrimaryWeaponRefill

# This defines the class for the Hero's Primary Weapon Refill Power-up

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal Callbacks

# See if Hero collected us
func _on_body_entered(body):
	if body.is_in_group("Hero"):
		collected()
