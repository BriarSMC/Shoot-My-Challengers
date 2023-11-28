extends Character
class_name Hero

# This class defines the Hero character which the player controls

# Properties

var moved: bool = false						# Whether Hero moved this frame

@onready var pWeapon: PackedScene = preload("res://Scenes/Weapons/hero_p_weapon.tscn")
@onready var sWeapon: PackedScene = preload("res://Scenes/Weapons/hero_s_weapon.tscn")

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
# Call the parent _ready
func _ready() -> void:
	if Globals.inputDevice == Globals.inputType.GAMECONTROLLER:
		$TargetPointer.visible = true
	else:
		$TargetPointer.visible = false
		
	global_position = find_parent("Level*").find_child("TeleportIn").global_position
	$CharacterImage.play("IdleEast")
	visible = true
	$TargetPointer.visible = false
	
	Globals.health = startingHealth
	Globals.primaryWeaponCount = startingPWeapon
	Globals.secondaryWeaponCount = startingSWeapon
	Globals.shortShieldCount = startingSShield
	Globals.longShieldCount = startingSShield
	
	super._ready()
	
# _process(delta)
# Called every frame of the game
#
# Parameters
#	delta: float				Time elapsed since last call
# Return 
#	None
#==
# Save the Hero's position so that other Characters know where we are.
func _process(_delta):
	Globals.heroPosition = position

# Class specific methods

# firePWeapon(pos, dir, rot)
# Creates amd fires the Hero's Primary Weapon
#
# Parameters
#	pos: Vector2				Starting position for the weapon
#	dir: Vector2				Direction the weapon will go
#	rot: float					Rotation applied to the weapon before firing it
# Return 
#	None
#==
# Create a new object for the weapon
# Set its position, direction and rotation
# Add it to the tree
func firePWeapon() -> void:
	print('Hero.firePWeapon')
	var weapon: Area2D  = pWeapon.instantiate()
	var rot: float	= self.rotation
	var pos: Vector2
	
	if Globals.inputDevice == Globals.inputType.GAMECONTROLLER:
		pos = $TargetPointer.global_position
	else:
		pos = get_viewport().get_global_mouse_position()

	weapon.position = self.global_position
	weapon.direction = (pos - self.position).normalized()
	weapon.look_at(pos)
	print(position)
	print(weapon.position)
	print(weapon.direction)
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
# Play the animation to make us visible
func spawn() -> void:	
	$CharacterImage/AnimationPlayer.play("FadeFromBlack")

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

# Trigger pulled, then call the firePWeapon method
func _on_hero_input_handler_fire_hero_p_weapon():
	firePWeapon()
