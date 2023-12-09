extends Node2D
class_name Chest

# This is the base class definition for any container in the game.
# It's primary purpose is to provide a place for items to spawn from, and
# to provide methods to instantiate them and position them on the level.
#
# We attach the contents of the chest in the Editor. At level instantiation
# We find what items we contain and load them into an array. We also hide
# them just incase we didn't hide them with the Editor.

# Properties
var chestClosed: bool = true						# Chest starts off closed
var contents: Array[Item] = []					# Items in the chest

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float

# The following are set based on the Inspector values

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
# Find out what we contain
# Hide them for now
func _ready() -> void:
	Globals.scaleMe(self.find_child("ChestImage"), scaleFactor)
	for c in get_children():
		if c.is_in_group('Item'):
			contents.push_back(c)
			c.visible = false

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
func open() -> void:
	if chestClosed:
		var animation = find_child("ChestImage")
		chestClosed = false
		SfxHandler.play_sfx(SfxHandler.SFX.OPEN)
		animation.play("Open")
		displayContents()

# displayContents()
# Make the contents of the chest visible
#
# Parameters
#		None
# Return
#		None
#==
# Loop through the contents array
# Make each item visible
# GIANT NOTE: Turns out that if the Hero is close enough to the chest when it
# opens, then some items are 'collected' before this method even runs. This
# causes visible=true to die a horrible death because we've already freed
# the object. So we check to see if the object is even there before manipulating
# it.
# Position it in a random location in front of the chest
func displayContents() -> void:
	var pos: Vector2
	for i in range(0, contents.size()):
		if is_instance_valid(contents[i]):
			contents[i].visible = true
			contents[i].startExpires()
			pos = Vector2(randi_range(-50, 10), randi_range(50, 70))
			contents[i].position = pos

# Signal Callbacks
