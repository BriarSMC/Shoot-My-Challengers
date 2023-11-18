extends Node2D
class_name Level4

#++
# This is the Level 2 scene
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

func _ready() -> void:
	Globals.scaleMe($PlayingArea, scaleFactor)		# Adjust how big we are
	
#+
# Class specific methods
#-

# Temp to exit the scene for debugging
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
