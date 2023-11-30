extends Weapon
class_name HeroSWeapon

# This class is for the Hero's secondary weapon: A bomb
#
# The Hero will drop this bomb and it will stay at that location until
# it detonates. It has a blast radius. All Challengers in that radius
# receive damage. Through magic shielding, the bomb does not damage
# the Hero.
#
# Since we won't be dropping a bizillion bombs at once, we will not use
# pooling for this weapon. Therefore, the DetentationTimer can autostart.
# It also is a one-shot because, well, it blows itself up!

# Signals

# Properties

var drawBlastRadius: bool = true

# The following properties must be set in the Inspector by the designer
@export var damageRadius: float				# Damage Challengers within this radius

# The following are set based on the Inspector values

# The following are set based on the Inspector values

# Virtual Godot methods

# _draw()
# Called to draw things on the canvas
#
# Parameters
#		None
# Return
#		None
#==
# Draw a circle around the weapon for blast radius
func _draw() -> void:
	if drawBlastRadius:
		draw_circle(Vector2.ZERO, damageRadius, Color(1,0,0,.1))

# Class specific methods

# Check for damage
# Called when the weapon explodes so we can see if it damaged anything
#
# Parameters
#		None
# Return
#		None
#==
# Find all the challenges in the scene
# If they are in our blast radius, then damage them
func checkForDamage() -> void:
	var challengers = find_parent('Level*').find_child('Challengers').get_children()
	for c in challengers:
		var dist = global_transform.origin.distance_to(c.global_transform.origin)
		if dist <= damageRadius * 2.0:	# NEVER DO SCALING AGAIN. Kludge to make distances work
			if c.has_method("takeDamage"):
				c.takeDamage(damage)


# Signal callbacks

# Hide the weapon
# Run the explosion animation
# Check if anything was damaged
func _on_detentation_timer_timeout():
	$WeaponImage.visible = false
	drawBlastRadius = false
	queue_redraw()
	$AnimatedSprite2D.play("Explosion")
	checkForDamage()


# We can go away now
func _on_animated_sprite_2d_animation_finished():
		deleteMe()
