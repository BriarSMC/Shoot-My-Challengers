extends Character
class_name SkullOfDeath

# This class defines the Skull of Death

# Signals

signal levelOver

# Properties

var arenaCenter: Vector2
var level: Level
var lungeActive: bool = false
var retreatActive: bool = false

var laserScene: PackedScene = preload("res://Scenes/Weapons/Laser.tscn")
var fireBlastScene: PackedScene = preload("res://Scenes/Weapons/fire_blast.tscn")

# The following properties must be set in the Inspector by the designer
@export var retreatSpeed: float = 200.0
@export var minLungeTime: float = 5.0
@export var maxLungeTime: float = 8.0

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Called when node is ready
#
# Parameters
#		None
# Return
#		None
#==
# Position us at the arena marker. This is our anchor point.
# Start our timers
# NOTE: Child must call super._ready() if it defines own _ready() method
func _ready() -> void:
	level = find_parent('Level*')
	arenaCenter = level.find_child('SkullArena').global_position
	global_position = arenaCenter

	startLaserTimer()
	startLungeTimer()

	super._ready()

# _process(delta)
# Called once per frame
#
# Parameters
#		delta: float				Time elapsed since last call
# Return
#		None
#==
# Check for lunging:
#		Move and check for collisions
#		When we collide, stop lunging and release the fireblast
# Check for retreating
#		Move badk toward the arena's center (velocity set when we get the signal
#		from the fire blast animation.
#		See if we are near the center of the arena.
#		If so, then stop the retreat and go back to arena center
func _process(delta) -> void:
	if lungeActive:
		var collision = move_and_collide(velocity * delta)
		if collision:
			lungeActive = false
			throwFireBlast()
	if retreatActive:
		move_and_slide()
		if global_transform.origin.distance_to(arenaCenter) <= 10:
			global_position = arenaCenter
			retreatActive = false
			$CharacterImage.play("Idle")

# Class specific methods

# lungeAtHero()
# Called to lunch at the Hero
#
# Parameters
#		None
# Return
#		None
#==
# Start the lunge timer
# Only if we are active
func lungeAtHero() -> void:
	startLungeTimer()
	$CharacterImage.play("Walk")
	if active:
		var dir: Vector2 = (Globals.heroPosition - global_position).normalized()
		velocity =  startingSpeed * dir
		lungeActive = true
		pass

# fireLaser()
# Fires the laser
#
# Parameters
#		None
# Return
#		None
#==
# Start the laser timer
# If we are in lunge/retreat then just return
# Fire laser if we are active
func fireLaser() -> void:
	startLaserTimer()
	if lungeActive or retreatActive: return
	if active:	pointAndShoot(laserScene)

# throwFireBlast()
# Throw the fireblast at the Hero
#
# Parameters
#		None
# Return
#		None
#==
# We don't use the parent's pointAndShoot because the Fire Blast
# doesn't move.
func throwFireBlast() -> void:
	var fireBlast: Area2D  = fireBlastScene.instantiate()
	fireBlast.position = Globals.heroPosition
	Globals.weaponsDeployed.add_child(fireBlast)
	fireBlast.connect('fireBlastComplete', fireBlastComplete)

# fireBlastComplete()
# FireBlast animation is finished. Start the retreat
#
# Parameters
#		None
# Return
#		None
#==
# Say we are retreating
# Set new velocity back to arena center
# Restart our timer
func fireBlastComplete() -> void:
	retreatActive = true
	velocity = retreatSpeed * (arenaCenter - global_position).normalized()
	#startLungeTimer()

# startLungeTimer()
# Called to star the lunge timer
#
# Parameters
#		None
# Return
#		None
#==
# Set a random time to fire
func startLungeTimer() -> void:
	$Timers/LungeTimer.wait_time = randf_range(minLungeTime, maxLungeTime)
	$Timers/LungeTimer.start()

# startLaserTimer()
# Called to set the laser timer
#
# Parameters
#		None
# Return
#		None
#==
# Set random time to fire
func startLaserTimer() -> void:
	$Timers/LaserTimer.wait_time = randf_range(2.0, 4.0)
	$Timers/LaserTimer.start()

func startDeath() -> void:
	$CharacterImage.play("Death")

# die()
# Called when hour health hits 0 or less
#
# Parameters
#		None
# Return
#		None
#==
# Indicate the level is finished
func die(sfx = SFXHandler.SFX.NULL) -> void:
	levelOver.emit()
	super.die(sfx)

# Signal Callbacks

# Make us active/inactive based on presence of Hero in Notice Area
func _on_notice_area_body_entered(body):
	if body.is_in_group("Hero"): active = true

func _on_notice_area_body_exited(body):
	if body.is_in_group("Hero"): active = false

func _on_lunge_timer_timeout():
	lungeAtHero()

func _on_laser_timer_timeout():
	fireLaser()


func _on_character_image_animation_finished():
	die(SFXHandler.SFX.NULL)
