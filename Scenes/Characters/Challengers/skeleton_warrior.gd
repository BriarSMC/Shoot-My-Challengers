extends Character
class_name SkeletonWarrior

# This class defines the Skeleton Warrior.
#
# Primary weapon is a knife. It has no secondary weapon.
# When the Hero moves into our Notice Area, then we move toward
# The Hero.

# Properties

var knifeScene: PackedScene = preload("res://Scenes/Weapons/knife.tscn")

var knifeCooldown: bool = false

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# _physics_process(delta)
# Called every physics frame
#
# Parameters
#		delta								Elapsed time since last call
# Return
#		none
#==
# See if we are active (Hero is in our Notice Area)
# If so
#		Move towards the Hero
#		Throw knives at the hero
func _physics_process(delta) -> void:
	if active:
		moveUs(delta)
		throwKnife()




# Class specific methods

# moveUs()
# Move our character toward the Hero
#
# Parameters
#		None
# Return
#		None
#==
# What the code is doing (steps)
func moveUs(_delta: float) -> void:
	var dir: Vector2 =  (Globals.heroPosition - self.position).normalized()
	velocity = speed * dir
	move_and_slide()

# throwKnife()
# Throw the knife at the Hero
#
# Parameters
#		paramname: type				Description
# Return
#		value|None					Description
#==
# If the knife is not in cooldown, then throw a knife
func throwKnife() -> void:
	if knifeCooldown:
		return

	knifeCooldown = true
	$Timers/ThrowTheKnife.start()
	var weapon: Area2D  = knifeScene.instantiate()
	var pos: Vector2 = Globals.heroPosition

	weapon.position = self.global_position
	weapon.direction = (pos - weapon.position).normalized()
	weapon.look_at(pos)
	Globals.weaponsDeployed.add_child(weapon)

# Something collided with our Notice Area. We only care about the hero.
func _on_notice_area_body_entered(body):
	if body.is_in_group("Hero"):
		active = true

# Something exited our Notice Araq. We only care about the hero.
func _on_notice_area_body_exited(body):
	if body.is_in_group("Hero"):
		active = false

# Cooldown period for the knife is over
func _on_throw_the_knife_timeout():
	knifeCooldown = false
