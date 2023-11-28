extends Node2D
class_name Chest

# This is the base class definition for any container in the game. 
# It's primary purpose is to provide a place for items to spawn from, and
# to provide methods to instantiate them and position them on the level.

# Properties
var chestClosed: bool = true

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float
@export var items: Array[Item]

# The following are set based on the Inspector values
@onready var itemsCount: int = items.size()

# Virtual Godot methods

# _ready()
# Called when object is ready
#
# Paramters
#	paramname: type				Description
# Return 
#	value|None					Description
#==
# Resize the graphic
func _ready() -> void:
	Globals.scaleMe(self, scaleFactor)
	
# Class specific methods

# openChest(animationPlayer)
# This method does the following:
#	* Plays the child's animation for the chest
#	* Waits until animation is finished
#	* Spawns the items contained in this chest
#
# Paramters
#	animationPlayer: AnimationPlayer	Reference to the child's AnimationPlayer
# Return 
#	value|None					Description
#==
# Open the chest only if its closed
func openChest(animationPlayer: AnimationPlayer) -> void:
	if chestClosed:
		chestClosed = false
		animationPlayer.play("Open")
		# Display items goes here
