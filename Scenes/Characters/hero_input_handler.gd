extends Node2D
class_name HeroInputHandler

# This defines the class that handles all input for the Hero

# Signals
signal fireHeroPWeapon
signal fireHeroSWeapon
signal shieldsChange

# Properties
@onready var hero: Object = self.find_parent("Hero")  # Get the Hero object
@onready var targetPointer: Object = hero.get_node("TargetPointer")

var shieldSound: AudioStreamPlayer
var primaryWeapon: HeroPWeapon

var primaryCooldownFinished: bool = true
var secondaryCooldownFinished: bool = true
var shieldActive: bool = false
#var immune: bool = false

# The following properties must be set in the Inspector by the designer
@export var targetSpeed: float = 500

# The following are set based on the Inspector values

# Virtual Godot methods

# _draw()
# Called when we need to draw things
#
# Parameters
#		None
# Return
#		None
#==
# Draw the shields if active
func _draw() -> void:
	if shieldActive:
		draw_circle(Vector2.ZERO, 30.0, Color(186.0/256.0, 127.0/256.0, 244.0/256.0, .39))	# rgba(186, 127, 244, 0.39)

# _physics_process(delta)
# Called every physics frame
#
# Parameters
#	delta: float				Time elapsed since last call
# Return
#	None
#==
# Move the Hero
func _process(delta):
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
# Enable powerup spawning
# Move the Hero
# Record Hero's new position
func moveHero() -> void:
	if not hero.active:
		return

	hero.direction = Input.get_vector("Left", "Right", "Up", "Down")
	if hero.direction == Vector2.ZERO:
		return

	hero.moved = true
	Globals.startSpawning = true
	hero.velocity = hero.speed * hero.direction
	hero.move_and_slide()
	Globals.heroPosition = hero.position

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
	if not Input.is_action_just_pressed("PrimaryWeapon") or \
		not hero.active:
		return

	if Globals.primaryWeaponCount <= 0:
		emptyWarning() #TODO Add sfx
		return

	if primaryCooldownFinished:
		primaryCooldownFinished = false
		$Timers/PrimaryCooldownTimer.start()
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
	if not Input.is_action_just_pressed("SecondaryWeapon") or \
		not hero.active:
		return

	if Globals.secondaryWeaponCount <= 0:
		emptyWarning() #TODO sfx
		return

	if secondaryCooldownFinished:
		secondaryCooldownFinished = false
		$Timers/SecondaryCooldownTimer.start()
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
# If the inventory is empty, then warn the player and return
# If the shields are active or the button wasn't press then just return.
# Use long shields first
# Reduce inventory
# Turn the shield on
func raiseShield() -> void:
	if not hero.active:
		return

	if Globals.shortShieldCount <= 0 and Globals.longShieldCount <= 0:
		emptyWarning()
		return

	if shieldActive or not Input.is_action_just_pressed("Shield"):
		return

	if Globals.longShieldCount > 0:
		Globals.longShieldCount -= 1
		shieldActive = true
		hero.immune = true
		queue_redraw()
		$Timers/ShieldsActiveTimer.wait_time = 5.0
		$Timers/ShieldsActiveTimer.start()
		shieldSound = SfxHandler.play_sfx(SfxHandler.SFX.SHIELD, self, Vector2.ONE, -26.0)
		return

	Globals.shortShieldCount -= 1
	shieldActive = true
	hero.immune = true
	queue_redraw()
	$Timers/ShieldsActiveTimer.wait_time = 3.0
	$Timers/ShieldsActiveTimer.start()
	shieldSound = SfxHandler.play_sfx(SfxHandler.SFX.SHIELD, self, Vector2.ONE, -26.0)


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

# takeDamage(damage)
# Called when something has caused us damage
#
# Parameters
#		damage: int					Amount to deduct from health
# Return
#		None
#==
# If we are immune, then just return
# Set our immunity
func takeDamage(damage: int) -> void:
	if hero.immune:
		return

	hero.immune = true
	$Timers/ImmuneTimer.start()

	Globals.health -= damage

# Signal Callbacks

func _on_shields_active_timer_timeout():
	shieldActive = false
	hero.immune = false
	queue_redraw()
	shieldSound.stop()

func _on_primary_cooldown_timer_timeout():
	primaryCooldownFinished = true

func _on_secondary_cooldown_timer_timeout():
	secondaryCooldownFinished = true

