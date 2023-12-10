extends GameControlScreen
class_name SplashScreen

# This defines the class for the splash screen.
#
# Not much going on here as it's all taken care of in the AnimationPlayer

# Properties

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
# Start the background music
# NOTE: Child must call super._ready() if it defines own _ready() method
func _ready() -> void:
	MusicHandler.playPrimary(MusicHandler.MUSIC.UIBG)
	super._ready()

# Class specific methods

# Signal Callbacks
