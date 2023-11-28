extends Mcp
class_name GameControlScreen

# This defines the parent class for all game control UI screens

# Signals

# Properties

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

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
