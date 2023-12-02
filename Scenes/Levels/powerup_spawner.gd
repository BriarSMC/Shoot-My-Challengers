extends Node2D
class_name PowerupSpawner

# This class handles spawning powerups in the level

# Properties

enum powerupType {EXTRALIFE, PWEAPON, SWEAPON, SSHIELD, LSHIELD}

var powerups: Array[PackedScene] =[
	preload("res://Scenes/Items/extra_life_points.tscn"),
	preload("res://Scenes/Items/primary_weapon_refill.tscn"),
	preload("res://Scenes/Items/secondary_weapon_refill.tscn"),
	preload("res://Scenes/Items/short_shield_refill.tscn"),
	preload("res://Scenes/Items/long_shield_refill.tscn")
]

# The following properties must be set in the Inspector by the designer
@export var extraLifeProbability: float = .25
@export var pWeaponRefillProbability: float = .30
@export var sWeaponRefillProbability: float = .15
@export var sShieldRefillProbability: float = .20
@export var lShieldRefillProbability: float = .10
@export var extraLifeQty: int = 5
@export var pWeaponRefillQty: int = 5
@export var sWeaponRefillQty: int = 1
@export var sShieldRefillQty: int = 1
@export var lShieldRefillQty: int = 1
@export var spawnTimerLow: float = 5.0
@export var spawnTimerHigh: float = 15.0

# The following are set based on the Inspector values
@onready var powerupValues: Dictionary = {
	powerupType.EXTRALIFE: [extraLifeProbability, extraLifeQty],
	powerupType.PWEAPON: [pWeaponRefillProbability, pWeaponRefillQty],
	powerupType.SWEAPON: [sWeaponRefillProbability, sWeaponRefillQty],
	powerupType.SSHIELD: [sShieldRefillProbability, sShieldRefillQty],
	powerupType.LSHIELD: [lShieldRefillProbability, lShieldRefillQty]
}

# Virtual Godot methods

# _ready()
# Called when node is ready
#
# Parameters
#		None
# Return
#		None
#==
# Set up the timer
func _ready() -> void:
	print('Setting new spawn timer')
	setNewTimer()

# Class specific methods

# setNewTimer()
# Set timer to expire at a random about of time between
# spawnTimerLow and spawnTimerHigh seconds.
#
# Parameters
#		None
# Return
#		None
#==
# What the code is doing (steps)
func setNewTimer() -> void:
	$SpawnTimer.wait_time = randf_range(spawnTimerLow, spawnTimerHigh)
	$SpawnTimer.start()

# spawnPowerup()
# Spawn a power-up
#
# Parameters
#		None
# Return
#		None
#==
# Only spawn if the Hero has actually moved
# 	Get the powerupType to spawn
# 	Make it real
# 	Position it, but don't let it go negative
# 	Give it a home with us
# Start the timer again
func spawnPowerup():
	if Globals.startSpawning:
		var i: int = selectPowerup()
		print('Selected powerup ', i)
		var powerup = powerups[i].instantiate()
		powerup.isPowerup = true
		powerup.position += Globals.heroPosition + Vector2(-100,80)
		if position.x <= 0: position.x = 20
		if position.y <= 0: position.y = 20

		add_child(powerup)

	setNewTimer()

# selectPowerup()
# Select a powerup to spawn
#
# Parameters
#		None
# Return
#		powerupType of the random powerup
#==
# Figure out which powerup to spawn
# So, we generate a random floating number between 0 and 1 and zero out
# the probability sum (prob).
# Loop through the powerupValues dictionary.
# Bump the probability sum by the probability of the current powerup.
# Test the probability sum # aginst the randon number.
# If ran is <= the  sum, then return the index of that powerup.
# The return 0 is there just to make GD happy.
func selectPowerup() -> int:
	print('Selecting powerup')
	var ran: float = randf_range(0.0, 1.0)
	var prob: float = 0.0
	for i in range(0, powerupValues.size()):
		prob += powerupValues[i][0]
		if ran <= prob: return i
	return 0

# Signal Callbacks

func _on_spawn_timer_timeout():
	print('Spawn timer fired')
	spawnPowerup()
