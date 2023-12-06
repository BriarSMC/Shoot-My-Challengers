extends CharacterBody2D
class_name Character

# This is the root class for all characters in the game.
# Right now that's the Hero and the Challengers.
#
# This class contains all properties and methods common to all
# character classes.

# Properties
var immune: bool = false
var active: bool = false
var direction: Vector2

var default_font = ThemeDB.fallback_font
var default_font_size = ThemeDB.fallback_font_size
const red: Color = Color(1,0,0)
const green: Color = Color(0,1,0)
var healthColor: Color

# The following properties must be set in the Inspector by the designer
@export var startingHealth: int	      			 # Character's starting health
@export var startingSpeed: float				 # Character's starting movement speed
@export var scaleFactor: float					 # Scale factor for Globals.scaleMe()

# The following are set based on the Inspector values
@onready var health: int = startingHealth		# Set character's starting health
@onready var speed: float = startingSpeed		# Set character's starting speed
@onready var isChallenger: bool = is_in_group("Challenger")
@onready var isHero: bool = is_in_group("Hero")

# Virtual Godot methods

# _ready()
# Called when node is ready
#
# Parameters
#	None
# Return
#	vNone
#==
# Scale the object
# NOTE: Child must call super._ready() if it defines own _ready() method
func _ready() -> void:
	Globals.scaleMe(self.find_child("CharacterImage"), scaleFactor)

# _draw()
# Called when draw functions need to happen
# What we are doing is putting the Challenger's
# Health status above their heads. Green unless it
# reaches a critical part, then it turns red.
#
# Parameters
#		None
# Return
#		None
#==
# Skip if we're the Hero
# Select the text color based on how low our health is
# Draw the health value
func _draw():
	if isHero:
		return

	if isChallenger:
		if health <= 15:
			healthColor = red
		else:
			healthColor = green

		draw_string(default_font, Vector2(-5, -50), str(health), HORIZONTAL_ALIGNMENT_CENTER, -1,
			default_font_size,  healthColor)

# Class specific methods

# pointAndShoot(weaponScene)
# Used to fire a projectile weapon
#
# Parameters
#		weaponScene: PackedScene	preload of the weapon's scene
# Return
#		None
#==
# What the code is doing (steps)
func pointAndShoot(weaponScene: PackedScene) -> void:
	var weapon: Area2D  = weaponScene.instantiate()
	var pos: Vector2 = Globals.heroPosition

	weapon.position = self.global_position
	weapon.direction = (pos - weapon.position).normalized()
	weapon.look_at(pos)
	Globals.weaponsDeployed.add_child(weapon)

# takeDamage(damage)
# Called by other nodes whenever they deal damage to us
#
# Paramters
#	damage: int The amount of health points to deduct from this character's health
# Return
#	None
#==
# Deduct the damage from character health
# If zero or less then call our instance's die method
func takeDamage(damage: int) -> void:
	health -= damage
	queue_redraw()
	if health <= 0:
		self.die()

# die()
#
# This is just a backup method in case one of the children inheriting this class
# doesn't have it's own die function to override this one.
#
# Usually called by takeDamage()
#
# Parameters
#	None
# Return
#	None
#==
# If we are a challenger, then decrement the counter
# Just get rid of the node
func die() -> void:
	if isChallenger: Globals.challengersLeft -= 1
	queue_free()

