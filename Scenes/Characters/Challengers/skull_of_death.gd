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
# NOTE: Child must call super._ready() if it defines own _ready() method
func _ready() -> void:
	level = find_parent('Level*')
	arenaCenter = level.find_child('SkullArena').global_position
	global_position = arenaCenter
	super._ready()

# Class specific methods

# Signal Callbacks

# Make us active/inactive based on presence of Hero in Notice Area
func _on_notice_area_body_entered(body):
	if body.is_in_group("Hero"): active = true

func _on_notice_area_body_exited(body):
	if body.is_in_group("Hero"): active = false
