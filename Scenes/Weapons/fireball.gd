extends Weapon
class_name Fireball

#++
# This class defines the fireball used by the Skeleton Grim Reaper.
#
# It is thrown towards the Hero on a random basis. When the animation completes,
# it then signals us to apply damage.
#
#--

#+
# Properties
#-
var FB_EX: int = 1						# Switch for which animation to play
const offset: float = 12.0				# Adjust where the fireball is positioned

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

#+
# Class specific methods
#-

#+
# Signal callbacks
#-

# _on_exploade_timer_timeout() 
# No idea what this is about
#
# Parameters
#	None
# Return 
#	None
#==
# What the code is doing (steps)
func _on_explode_timer_timeout():
	if FB_EX == 1:
		position.x += offset
		$AnimatedSprite2D.play("Explosion")
		FB_EX = 2
	else:
		position.x -= offset
		$AnimatedSprite2D.play("Throw")
		FB_EX = 1
