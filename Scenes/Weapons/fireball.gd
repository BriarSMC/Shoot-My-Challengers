extends Weapon
class_name Fireball

# This class defines the fireball used by the Skeleton Grim Reaper.
#
# It is thrown towards the Hero on a random basis. If it timesout, then we just
# explode. If it hits the Hero, the we explode and apply damage.

# Signals

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Called when node is ready
#
# Parameters
#	None
# Return
#	None
#==
# What the code is doing (steps)
# NOTE: Child must call super._ready() if it defines own _ready() method
func _ready() -> void:
	super._ready()

# Class specific methods

# explode()
# Called when we need to explode the fireball
#
# Parameters
#	None
# Return
#	None
#==
# Play the explosion
func explode(pos: Vector2) -> void:
	speed = 0
	position = pos
	$WeaponImage.play("Explosion")

# Signal callbacks

# If the fireball hasn't hit anyting by now,
# then explode it
func _on_explode_timer_timeout():
	explode(position)

# When the animation finishes, the we can go away
func _on_animated_sprite_2d_animation_finished():
	deleteMe()

# If we contact the Hero, then explode and apply damage
func _on_body_entered(body):
	if body.is_in_group("Hero"):
		body.takeDamage(damage)
		explode(body.global_position)
	else:
		explode(position)
