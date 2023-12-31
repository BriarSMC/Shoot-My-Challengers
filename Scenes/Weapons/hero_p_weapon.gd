extends Weapon
class_name HeroPWeapon

# This is the class for the Hero's Primary Weapon (Arrow).

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# Class specific methods

# Signal callbacks

# _on_body_entered(body)
# Called when we collide with something
#
# Parameters
#	body: Object				What we hit
# Return
#	None
#==
# Was it a Challenger?
# If so, then we tell the Challenger we hit them
# Was it a Container (chest)
# If so, then call it's open method
# Regardless, we always delete ourself after a collision
func _on_body_entered(body):
	if body.is_in_group("Challenger"):
		if body.has_method("takeDamage"):
			body.takeDamage(damage)

	if body.is_in_group("Container"):
		body.open()

	deleteMe()

# Arrow can only go so far
func _on_arrow_range_timer_timeout():
	deleteMe()
