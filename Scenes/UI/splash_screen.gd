extends GameControlScreen
class_name SplashScreen

#++
# This defines the class for the splash screen.
#
# Not much going on here as it's all taken care of in the AnimationPlayer
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
# Called when object is ready
#
# Parameters
#	None
# Return 
#	None
#==
# Set the background image for the parent class
#func _ready() -> void:
#	print("Child pos: ", self.position, self.global_position)
#	print("Child name: ", self.name)
#	Globals.positionUIImage(self)	
#	super._ready()

func _process(_delta):
	Globals.positionUIImage(self)	
#+
# Class specific methods
#-

