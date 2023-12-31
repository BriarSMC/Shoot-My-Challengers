extends Area2D
class_name Weapon
#++
# This is the base class for all Weapons in the game.
#
# This class contains all properties and methods common to all
# character classes.
#--

#+
# Properties
#-
var velocity: Vector2
var direction: Vector2

var pooled: bool = false				# Override in child using _enter_tree()
var tmp: int

# The following properties must be set in the Inspector by the designer
@export var damage: int
@export var startingSpeed: float
@export var scaleFactor: float

# The following are set based on the Inspector values
@onready var speed: float = startingSpeed

#+
# Virtual Godot methods
#-

# _ready()
# Called when the object is ready
#
# Paramters
#	None
# Return
#	None
#==
# Scale our image and colliders
func _ready() -> void:
	Globals.scaleMe(self, scaleFactor)

# _process(delta)
# Called every frame
#
# Parameters
#	delta						Time elapsed since last call
# Return
#	None
#==
# Move the weapon
# NOTE: Set speed to zero if the weapon doesn't move
func _process(delta) -> void:
	position += direction * (speed * delta)

#+
# Class specific methods
#-

# deleteMe()
# Called by the child when the weapon can be removed from the scene tree.
# Usually because the weapons has struck something and no longer exists now.
# This is pretty much a place holder cuz we are going to try object pooling
# a while from now.
#
# Paramters
#	None
# Return
#	None
#==
# What the code is doing (steps)
func deleteMe() -> void:
	queue_free() # For now
