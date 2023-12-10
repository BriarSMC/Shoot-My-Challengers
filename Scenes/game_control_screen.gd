extends Mcp
class_name GameControlScreen

# This defines the parent class for all game control UI screens

# Signals

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

# _enter_tree()
# Called when the node is in the tree
#
# Parameters
#		None
# Return
#		None
#==
# So, why is this here and not in _ready()? Cuz I don't understand the order
# of execution for _ready() methods. The documentation and posts about _ready()
# lead me to think that they are executed in tree order. Don't think so. It may
# be reverse tree order (I'll have to look into it). Anyway, Globals.sfxNode needs
# to be set before any other node runs its _ready() because some of them play
# a sound in the _ready() method. Hmm. Playing a sound requires Globals.sfxNode
# to be set to the level's SFX node. Oh, BTW, each level needs to have an FSX
# node. At a later date I may just have the Level class create one dynamically.
# But that would have to be in _enter_tree() too and I don't know if it makes
# sense or is 'legal' to create nodes during this time.
#
# Also, it may make more sense to move sfxNode to SfxHandler.
func _enter_tree() -> void:
	Globals.sfxNode = find_child("SFX")
# _ready()
# Called when the object is ready
#
# Parameters
#	None
# Return
#	None
#==
# Reposistion the graphic to the center of the screen
func _ready():
	Globals.positionUIImage(self)
	super._ready()

# _process(_delta)
# Called once per frame
#
# NOTE: MAKE SURE THE CHILD CALLS US! (super._process(delta))
#
# Parameters
#	delta: float				Time elapsed since last call
# Return
#	None
#==
# Reposition the graphic
func _process(delta):
	Globals.positionUIImage(self)
	super._process(delta)


# _input(event)
# Called whenever an input event occurs
#
# Parameters
#	event						Describes the input event
# Return
#	None
#==
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

# Class specific methods

# Signal callbacks
