extends Weapon
class_name HeroPWeapon

#++
# This is the class for the Hero's Primary Weapon (Arrow).
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-




#+
# Class specific methods
#-

#++
# Signal callbacks
#--

func _on_body_entered(body):
	print('HeroPWeapon hit ', body.name)
	# See what we hit. If it's a Challenger, then send damaage
	if body.is_in_group("Challenger"):
		pass # Replace with damage call
	# We can go away now
	self.queue_free()
