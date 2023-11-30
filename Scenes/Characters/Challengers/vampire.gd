extends Character
class_name Vampire

# This is the definition for the Vampire.
#
# NOTE: The vampire doesn't move.
#
# He 'hypnotizes' the Hero to draw him near so he can suck his blood.

# Properties
var startBiting: bool = false
var hero: Hero

# The following properties must be set in the Inspector by the designer
@export var damage: int = 20						# Normally a weapon property, but we are the weapon

# The following are set based on the Inspector values

# Virtual Godot methods

# _process(delta)
# Called every frame
#
# Parameters
#		delta: float							Time elapsed since last call
# Return
#		None
#==
# What the code is doing (steps)
func _process(_delta) -> void:
	if active and startBiting:
		biteHero()
		startBiting = false

# Class specific methods

# biteHero()
# Bite the hero
#
# Parameters
#		Nonen
# Return
#		None
#==
# Send damage to hero
func biteHero() -> void:
	hero.takeDamage(damage)
	$BitingTimer.start()

# Signal Callbacks

# Only care about Hero
# Save pointer to Hero
# Hypnotize him
func _on_notice_area_body_entered(body):
	if body.is_in_group("Hero"):
		print('Hypnotizing Hero')
		hero = body
		active = true
		body.hypnotize(self)
		$NoticeArea/NoticeAreaCollider.set_disabled(true)

# Only care about Hero
# Really shouldn't be called since we disable the collider on contact
func _on_notice_area_body_exited(body):
	if body.is_in_group("Hero"):
		active = false
		body.hypnotize(self, false)

# Only care about Hero
# Start biting
# Tell Hero he's touched the Vampire
func _on_area_2d_body_entered(body):
	if body.is_in_group("Hero"):
		print('Hero has touched the vampire')
		startBiting = true
		body.hitTheVampire()


# Stop hypnotism
# TODO: Stop any biting media
func _on_biting_timer_timeout():
	print('Stop the hypnotism')
	hero.hypnotize(self, false)
