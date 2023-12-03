extends Character
class_name SkullOfDeath

# This class defines the Skull of Death

# Properties

var arenaCenter: Vector2
var level: Level

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
# Draw a circle for the arena
# NOTE: Child must call super._ready() if it defines own _ready() method
func _ready() -> void:
	level = find_parent('Level*')
	arenaCenter = level.find_child('SkullArena').position
	position = arenaCenter
	_draw()
	super._ready()

# _draw()
# Called when any drawing needs to be done
#
# Parameters
#		None
# Return
#		None
#==
# Draw a circle for the Skull Arena
# NOTE: Child must call super._ready() if it defines own _ready() method
func _draw() -> void:
	print('Drawing arena')
	draw_circle(arenaCenter, level.arenaRadius, Color(.8, .68, 0, .2))

# Class specific methods

# Signal Callbacks
