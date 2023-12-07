extends Character
class_name SkeletonGrimReaper
# This character 'stalks' the Hero. When the Hero is in out Notice Area, then
# we use a Naviation Agent to move toward him. The NavigationRegion2D in the
# current level defines our area of operation.
#
# We also play special music when the Hero is in our Notice Area.

# Properties

var scytheCooldown: bool = false
var fireballCooldown: bool = false

var fireballScene: PackedScene = preload("res://Scenes/Weapons/fireball.tscn")

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Executed when the node is ready
#
# Paramters
#	None
# Return
#	None
#==
# Calculate the first target position for the path
func _ready() -> void:
	$NavigationAgent2D.target_position = Globals.heroPosition
	super._ready()

# _physics_process(delta)
# Called every physics cycle
#
# Paramters
#	delta: float				Amount of time elaped since last call
# Return
#	None
#==
# Only run the path and move code if the Hero is in our notice area
#	Calculate the new path and move us along the path
#	# If we upgrade the graphics, then we should look at the dude
func _physics_process(_delta) -> void:
	#return # TAKE THIS OUT WHEN YOU WANT TO DO REAL STUFF
	# May have to do a called deferred if the first from being null is a problem
	var hero

	if active:
		useFireball()
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var dir: Vector2 = (next_path_position - global_position).normalized()
		velocity = dir * speed
		if move_and_slide():
			hero = get_last_slide_collision().get_collider()
			if hero.is_in_group("Hero"):
				useScythe(hero)


# Class specific methods

func useFireball() -> void:
	if fireballCooldown: return
	$Timers/FireballCooldownTimer.start()
	fireballCooldown = true
	pointAndShoot(fireballScene)

func useScythe(hero: Hero) -> void:
	if scytheCooldown: return
	$Timers/ScytheCooldownTimer.start()
	scytheCooldown = true
	$Scythe.startAnimation()
	hero.takeDamage($Scythe.damage)
	print('Hitting ', hero.name, ' for damange of ', $Scythe.damage)


func startDeath() -> void:
	$CharacterImage.play("Death")

# Signal callbacks


func _on_recalculate_path_timer_timeout() -> void:
	$NavigationAgent2D.target_position = Globals.heroPosition


# If it's the Hero, then set the active flag
# TODO: Play Music
func _on_notice_area_body_entered(body):
	if body.is_in_group("Hero"):
		active = true


# If it's the Hero, then clear the active flag
# TODO: Turn off music
func _on_notice_area_body_exited(body):
	if body.is_in_group("Hero"):
		active = false

func _on_scythe_cooldown_timer_timeout():
	print('Scythe cooldown timer fired')
	scytheCooldown = false


func _on_fireball_cooldown_timer_timeout():
	fireballCooldown = false


func _on_character_image_animation_finished():
	super.die()
