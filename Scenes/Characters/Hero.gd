extends Character
class_name Hero
#++
# This class defines the Hero character which the player controls
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

# _ready()
# Our _ready method
#
# Paramters
#	None
# Return 
#	None
#==
# Just a debug print.
# TODO: Delete this if we don't add any real functionality
func _ready() -> void:
	print('Hero ready')
	print('Hero health ', health)
	print('Hero scaleFactor ', scaleFactor)
	print('Hero speed ', speed)
	super._ready()
	
	
func _process(_delta):
	Globals.heroPosition = position
#+
# Class specific methods
#-

# die()
# Called by the Character class when our health hits zero
#
# Paramters
#	None
# Return 
#	None
#==
# Debug print for now
# Call the parent class to do any cleanup work
func die() -> void:
	print('Hero died')
	super.die()
