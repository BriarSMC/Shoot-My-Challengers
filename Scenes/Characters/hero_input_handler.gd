extends Node2D
class_name HeroInputHandler

#++
# This defines the class that handles all input for the Hero
#
#--

#+
# Properties
#-
@onready var hero: Object = self.find_parent("Hero")  # Get the Hero object

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

# _ready()
# Called when the node is ready
#
# Parameters
#	None
# Return 
#	None
#==
# Nothing at this time
func _ready() -> void:
	pass
	
# _physics_process(delta)
# Called every physics frame
#
# Parameters
#	delta: float				Time elapsed since last call
# Return 
#	None
#==
# Move the Hero
func _physics_process(_delta):
	pollInput()

# _input(event)
# Called whenever an input event occurs
#
# Parameters
#	event: InputEvent			Input received from the player
# Return 
#	None
#==
# Get the movement vector from Godot
# If we've moved (vector is non-zero), then move the Hero
#		
func pollInput() -> void:
	hero.direction = Input.get_vector("Left", "Right", "Up", "Down")
	if hero.direction != Vector2.ZERO:
		move()

#+
# Class specific methods
#-

# move()
# Move Hero accordingly
#
# Parameters
#	None
# Return 
#	None
#==
# Just return if we aren't active yet
# Set that we've moved
# Set the new velocity
# Move the Hero
# Record Hero's new position
func move() -> void:
	if not hero.active:
		return
		
	hero.moved = true
	hero.velocity = hero.speed * hero.direction
	hero.move_and_slide()
	Globals.heroPosition = hero.global_position

#+
# Signal Callbacks
#-
