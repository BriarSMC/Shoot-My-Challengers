extends CharacterBody2D
class_name Character
#++
# This is the root class for all characters in the game.
# Right now that's the Hero and the Challengers.
#
# This class contains all properties and methods common to all
# character classes.

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer
@export var startingHealth: int	      			 # Character's starting health 
@export var startingSpeed: float				 # Character's starting movement speed
@export var scaleFactor: float					 # Scale factor for Globals.scaleMe()

# The following are set based on the Inspector values
@onready var health: int = startingHealth		# Set character's starting health
@onready var speed: float = startingSpeed		# Set character's starting speed

# The following properties are common to all characters
var immune: bool = false
var active: bool = false

#+
# Virtual Godot methods
#-

# Required: Child must call super._ready() if it defines own _ready() method
func _ready() -> void:
	Globals.scaleMe(self, scaleFactor)
	
#+
# Class specific methods
#-

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
	if health <= 0:
		self.die()
		
# dir()
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
# Just get rid of the node
func die() -> void:
	queue_free()
		
