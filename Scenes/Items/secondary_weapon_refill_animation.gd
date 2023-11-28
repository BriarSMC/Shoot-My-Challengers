extends AnimationPlayer

# This code causes the Hero's Secondary Weapon Refill Power-up to
# bob up and down.

# Properties
var incr: float = 3.0
var dir: float = 1.0
var pos: float = 0.0

const upperLimit: float = 20.0
const lowerLimit: float = -20.0

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods

	
# Class specific methods

# _process(delta)
# Called for every frame of the game loop
#
# Cause the image to bob up and down
#
# Parameters
#	delta: float				Time elapsed since last call
# Return 
#	None
#==
# Bob up and down. Change directions when the limits are met.
func _process(delta):
	$"..".position.y = pos + (incr * dir * delta)
	if (pos <= lowerLimit):
		dir = 1.0
	if (pos >= upperLimit):
		dir = -1.0

# Signal callbacks
