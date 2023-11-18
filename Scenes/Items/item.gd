extends Node2D
class_name Item

#++
# This defines the parent class for an Item.
#
#--

#+
# Properties
#-

# Designer will choose one of these types in the Inspector
enum itemIs {COIN, GEM, LIFE, }

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float
@export var increaseItemCountBy: int
@export var itemType: itemIs

# The following are set based on the Inspector values

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
# Scale our image
func _ready() -> void:
	Globals.scaleMe(self, scaleFactor)
	
#+
# Class specific methods
#-

# weHaveBeenCollected()
# Called by the child when a collision with the Hero is detected.
#
# Increments the appropriate counter
#
# Paramters
#	None
# Return 
#	None
#==
# Bump the appropriate counter based on our type
func weHaveBeenCollected() -> void:
	match itemType:
		itemIs.COIN:
			Globals.coinCount += increaseItemCountBy
		itemIs.GEM:
			Globals.gemCount += increaseItemCountBy
		itemIs.LIFE: 
			Globals.maxHealth += increaseItemCountBy
