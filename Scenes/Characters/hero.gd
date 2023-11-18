extends Character
class_name Hero

#++
# This class defines the Hero character which the player controls
#
#--

#+
# Properties
#-

var isActive: bool = false				# Has to wait for the teleport effect to finish

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Get the position of the spawn point

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
# Move us to the spawn location
# Look East
# Remember to call the parent
func _ready() -> void:
	position = find_parent("Level*").find_child("TeleportIn").position
	$HeroGraphic.play("IdleEast")
	visible = true
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

# spawn()
# Spawn the Hero with a teleport effect
#
# Each level has a TeleportIn Marker2D. This is the location where the Hero will
# spawn/teleport in. We capture this location with an @onready to load spawnPosition.
#
#
# Parameters
#	paramname: type				Description
# Return 
#	value|None					Description
#==

# Make us visible
func spawn() -> void:
	
	$HeroGraphic/AnimationPlayer.play("FadeFromBlack")


#+
# Signal callbacks
#-

func _on_spawn_timer_timeout():
	spawn()


func _on_teleport_effect_animation_finished():
	isActive = true
