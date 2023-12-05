extends Character
class_name SkullOfDeath

# This class defines the Skull of Death

# Properties

var arenaCenter: Vector2
var level: Level

var laserScene: PackedScene = preload("res://Scenes/Weapons/Laser.tscn")
var fireBlastScene: PackedScene = preload("res://Scenes/Weapons/fire_blast.tscn")

# The following properties must be set in the Inspector by the designer

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
func lungeAtHero() -> void:
	startLungeTimer()

# fireLaser()
# Fires the laser
#
# Parameters
#		None
# Return
#		None
#==
# Start the laser timer
func fireLaser() -> void:
	startLaserTimer()
	if active:	pointAndShoot(laserScene)

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
	$Timers/LungeTimer.wait_time = randf_range(2.0, 8.0)
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
