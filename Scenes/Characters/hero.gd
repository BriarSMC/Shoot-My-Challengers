extends Character
class_name Hero

# This class defines the Hero character which the player controls
# NOTE: Do not use the health in the Character class for the hero.
# Use the health and maxHealth in Globals for Hero's health status.

# Properties

var moved: bool = false						# Whether Hero moved this frame
var hitVampire: bool							# We've made contact with the Vampire
var hypnotized: bool = false			# Whether or not we are hypnotized
var hypnoDir: Vector2							# Direction of Vampire
var hypnoSpeed: float							# Movement speed while hypnotized
var vampire: Vampire							# Vampire hypnotizing us

@onready var pWeapon: PackedScene = preload("res://Scenes/Weapons/hero_p_weapon.tscn")
@onready var sWeapon: PackedScene = preload("res://Scenes/Weapons/hero_s_weapon.tscn")

const PWEAPON_SFX = preload("res://Audio/SoundEffects/Retro Weapon Arrow 02.mp3")
const SWEAPON_SFX = preload("res://Audio/SoundEffects/Retro Impact Metal 05.mp3")
const EXPLOSION_SFX = preload("res://Audio/SoundEffects/Retro Weapon Bomb 06.mp3")
const EMPTY_SFX = preload("res://Audio/SoundEffects/419023__jacco18__acess-denied-buzz-amplified.mp3")

# The following properties must be set in the Inspector by the designer
@export var startingPWeapon: int
@export var startingSWeapon: int
@export var startingSShield: int
@export var staringLShield: int

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Called when the node is ready
#
# Paramters
#	None
# Return
#	None
#==
# See if we are using a game controller
# Turn on TargetPointer if using game controller
# Move us to the spawn location
# Look East
# Remember to call the parent
# Set health and inventory
# Set hypnotize stuff
# Call the parent _ready
# Save where we are
func _ready() -> void:
	if Globals.inputDevice == Globals.inputType.GAMECONTROLLER:
		$TargetPointer.visible = true
	else:
		$TargetPointer.visible = false

	global_position = find_parent("Level*").find_child("TeleportIn").global_position
	$Character/CharacterImage.play("IdleEast")
	visible = true
	$TargetPointer.visible = false

	Globals.health = startingHealth
	Globals.maxHealth = startingHealth
	Globals.primaryWeaponCount = startingPWeapon
	Globals.secondaryWeaponCount = startingSWeapon
	Globals.shortShieldCount = startingSShield
	Globals.longShieldCount = startingSShield

	hypnoSpeed = speed/2.0

	Globals.heroPosition = position

	super._ready()

# _process(delta)
# Called every frame
#
# Parameters
#		delta: float						Time elapsed since last call
# Return
#		None
#==
# If we are hypnotized, then move to the Vampire
# Stop moving if we are dead
func _process(delta) -> void:
	if hypnotized and not hitVampire:
		position += hypnoDir * hypnoSpeed * delta
	if Globals.health <= 0: active = false

# Class specific methods

# firePWeapon()
# Creates amd fires the Hero's Primary Weapon
#
#	Parameters
#		None
#	Return
#		None
#==
# Create a new object for the weapon
# Set its position, direction and rotation
# Add it to the tree
func firePWeapon() -> void:
	var weapon: Area2D  = pWeapon.instantiate()
	var pos: Vector2

	if Globals.inputDevice == Globals.inputType.GAMECONTROLLER:
		pos = $TargetPointer.global_position
	else:
		pos = get_viewport().get_global_mouse_position()

	weapon.position = self.global_position
	weapon.direction = (pos - self.position).normalized()
	weapon.look_at(pos)
	Globals.weaponsDeployed.add_child(weapon)
	SfxHandler.play_sfx(SfxHandler.SFX.HEROPWEAPON, self, Vector2.ONE, -16)

# fireSWeapon()
# Creates amd fires the Hero's Secondary Weapon
#
# Parameters
#		Nonet
# Return
#		None
#==
# Create a new object for the weapon
# Set its position
# Add it to the tree
func fireSWeapon() -> void:
	var weapon: Area2D  = sWeapon.instantiate()

	weapon.position = self.global_position
	weapon.direction = Vector2.ZERO
	Globals.weaponsDeployed.add_child(weapon)

# getDirection(src, tgt)
# Return the direction from source to target
#
# Parameters
#	src: Object					Oject shooting
#	tgt: Object 				Object of the target
# Return
#	Vector2						Direction to the target
#==
#
func getDirection(src: Object, tgt: Object = self, useTargetPointer: bool = true) -> Vector2:
	var to: Object
	if useTargetPointer:
		to = $TargetPointer
	else:
		to = tgt

	return (to.get_global_position() - src.position).normalized()

func takeDamage(damage: int) -> void:
	if immune: return
	Globals.health -= damage
	super.takeDamage(damage)

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
# Play the animation to make us visible
func spawn() -> void:
	$Character/CharacterImage/AnimationPlayer.play("FadeFromBlack")

# hypnotize(byWhom: Vampire, sw: bool)
# A vampire has hypnotized us. Dire things happen.
# All player input is disabled.
# Hero walks strait to the vampire.
# When they collide, then vampire sucks our blood.
#
# Parameters
#		byWhom: Vampire			Who is hypnotizing us
#		sw: bool						true: Begin hypnotize, false: End hypnotize
#													Default is true
# Return
#		None
#==
# Make us inactive. That causes the input handler to stop responding to
# movement and weapons.
# Get the direction to the vampire
# Save who is hypnotizing us
func hypnotize(byWhom: Vampire, sw: bool = true) -> void:
	hitVampire = false
	hypnotized = sw
	active = not sw
	hypnoDir = (byWhom.get_global_position() - self.position).normalized()
	vampire = byWhom

func hitTheVampire():
	hitVampire = true

# Signal callbacks

# Spawn us when the timer fires
func _on_spawn_timer_timeout():
	spawn()

# We can set the Hero as active now
# If the game controller is plugged in, then turn on the target pointer
func _on_teleport_effect_animation_finished():
	active = true
	if Globals.inputDevice == Globals.inputType.GAMECONTROLLER:
		$TargetPointer.visible = true

# Primary Trigger pulled, then call the firePWeapon method
func _on_hero_input_handler_fire_hero_p_weapon():
	firePWeapon()

# Secondary Trigger pulled, then call the fireSWeapon method
func _on_hero_input_handler_fire_hero_s_weapon():
	fireSWeapon()

