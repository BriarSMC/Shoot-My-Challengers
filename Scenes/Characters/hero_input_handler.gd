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
@onready var targetPointer: Object = hero.get_node("TargetPointer")

# The following properties must be set in the Inspector by the designer
@export var targetSpeed: float = 500

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
# If a game controller is hooked up, then hide the mouse
# cuz we'll be using the Hero's TargetPointer for aiming.
func _ready() -> void:
	if hero.inputType.GAMECONTROLLER:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
# _exit_tree()
# Called when the node is destroyed
#
# Parameters
#	None
# Return 
#	None
#==
# Just make the mouse visible regardless
func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
# _physics_process(delta)
# Called every physics frame
#
# Parameters
#	delta: float				Time elapsed since last call
# Return 
#	None
#==
# Move the Hero
func _physics_process(delta):
	pollInput(delta)

# pollInput(delta)
# Called whenever an input event occurs
#
# Parameters
#	delta: float					Time elapsed since last call
# Return 
#	None
#==
# Get the movement vector from Godot
# If we've moved (vector is non-zero), then move the Hero
#		
func pollInput(delta) -> void:
	moveTarget(delta)	
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

# positionCursor(delta)
# Called to move cursor to new location via gamepad
#
# Parameters
#	delta: float				# Time elapsed since last call
# Return 
#	None
#==
# Ignore if game controller is not connected
# Get the Hero's target pointer position
# Get the controller's input vector for the joystick
# Ignore if the vector is zero (no movement)
# Otherwise update the new position
# 
func moveTarget(delta) -> void:
	if hero.inputDevice != hero.inputType.GAMECONTROLLER:
		return

	var targetPosition: Vector2 = targetPointer.position
	var targetVelocity: Vector2 = Input.get_vector("CursorLeft", "CursorRight", "CursorUp", "CursorDown")
	if targetVelocity != Vector2.ZERO:
		targetPointer.position += (targetVelocity * targetSpeed * delta)

#+
# Signal Callbacks
#-
