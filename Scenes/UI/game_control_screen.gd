extends CanvasLayer
class_name GameControlScreen

#++
# This defines the parent class for all game control UI screens
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer
@export var winScreen : PackedScene				# Graphic for this scene

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-
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
	Globals.positionUIImage($Sprite2D)	

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
func _process(_delta):
	Globals.positionUIImage($Sprite2D)

#+
# Class specific methods
#-
# goToNextScreen()
# This method loads the next screen. 
#
# HUGE NOTE: The end of $Sprite2D/AnimationPlayer needs to call this method
#
# Paramters
#	paramname: type				Description
# Return 
#	value|None					Description
#==
# Call the MCP to change over to the next screen		
func goToNextScreen(nextScene: int, level: int):
	MCP.changeGameState(nextScene, level)
