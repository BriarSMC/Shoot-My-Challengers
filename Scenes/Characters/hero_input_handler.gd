extends Node
class_name HeroInputHandler

# This defines the class that handles all input for the Hero

# Signals
signal fireHeroPWeapon
signal fireHeroSWeapon

# Properties
@onready var hero: Object = self.find_parent("Hero")  # Get the Hero object
@onready var targetPointer: Object = hero.get_node("TargetPointer")

var primaryWeapon: HeroPWeapon

var primaryCooldownFinished: bool = true
var secondaryCooldownFinished: bool = true
var shieldActive: bool = false

# The following properties must be set in the Inspector by the designer
@export var targetSpeed: float = 500

# The following are set based on the Inspector values

# Virtual Godot methods

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
# Exit the game if the player says to do so
# Get the movement vector from Godot
# If we've moved (vector is non-zero), then move the Hero
#
func pollInput(delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	moveTarget(delta)
	moveHero()
	firePrimary()
	fireSecondary()
	raiseShield()

	if Input.is_key_pressed(KEY_Z): # Debug/Test GamePlayUI
		Globals.coinCount += 1

# Class specific methods

# moveHero()
# Move Hero accordingly
#
# Parameters
#	None
# Return
#	None
#==
# Just return if we aren't active yet
# Get the input vector
# If it's zero, then just return
# Set that we've moved
# Set the new velocity
# Move the Hero
# Record Hero's new position
func moveHero() -> void:
	if not hero.active:
		return

	hero.direction = Input.get_vector("Left", "Right", "Up", "Down")
	if hero.direction == Vector2.ZERO:
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
	if Globals.inputDevice != Globals.inputType.GAMECONTROLLER:
		return

	var targetVelocity: Vector2 = Input.get_vector("CursorLeft", "CursorRight", "CursorUp", "CursorDown")
	if targetVelocity != Vector2.ZERO:
		targetPointer.position += (targetVelocity * targetSpeed * delta)

# firePrimary()
# If the player activates the primary weapon, then fire it
#
# Parameters
#	None
# Return
#	None
#==
# If the inventory is empty, then warn the player
# Instantiate a new weapon object
# Fire it at the TargetPointer
# Decrement the inventory
func firePrimary() -> void:
	if not Input.is_action_just_pressed("PrimaryWeapon")	:
		return

	if Globals.primaryWeaponCount <= 0:
		print('Primary weapon empty')
		emptyWarning()
		return

	if primaryCooldownFinished:
		print('HeroInputHandler emitting fireHeroPWeapon')
		Globals.primaryWeaponCount -= 1
		fireHeroPWeapon.emit()

# fireSecondary()
# If the player activated secondary weapon, then fire it
#
# Parameters
#	None
# Return
#	None
#==
# If the inventory is empty, then warn the player
func fireSecondary() -> void:
	if not Input.is_action_just_pressed("SecondaryWeapon")	:
		return

	if Globals.secondaryWeaponCount <= 0:
		print('Secondary weapon empty')
		emptyWarning()
		return

	if secondaryCooldownFinished:
		print('HeroInputHandler emitting fireHeroSWeapon')
		Globals.secondaryWeaponCount -= 1
		fireHeroSWeapon.emit()


# func raiseShield()
# If player activates the shield, then raise it
#
# Parameters
#	None
# Return
#	None
#==
# If the inventory is empty, then warn the player
func raiseShield() -> void:
	if Globals.shortShieldCount <= 0 and Globals.longShieldCount <= 0:
		emptyWarning()
		return

# emptyWarning()
# If the player tries to activate a weapon or shield and the inventory is empty,
# then SMC executes this method
#
# Parameters
#	None
# Return
#	None
#==
# Play empty sound
func emptyWarning() -> void:
	pass


# Signal Callbacks
