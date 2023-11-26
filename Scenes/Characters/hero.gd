extends Character
class_name Hero

#++
# This class defines the Hero character which the player controls
#
#--

#+
# Properties
#-

enum inputType {KEYBOARD, GAMECONTROLLER, }

var inputDevice: inputType
var moved: bool = false							# Whether Hero moved this frame

# The following properties must be set in the Inspector by the designer
@export var startingPWeapon: int 
@export var startingSWeapon: int
@export var startingSShield: int
@export var staringLShield: int

# The following are set based on the Inspector values

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
# Connect to signals
# See if we are using a game controller
# If not, then we set to keyboard/mouse
# Move us to the spawn location
# Look East
# Remember to call the parent
# Set inventory
func _ready() -> void:
	connect("fireHeroPWeapon", firePWeapon)

	if Input.get_connected_joypads().size() > 0:
		inputDevice = inputType.GAMECONTROLLER
#		$TargetPointer.position = self.position + Vector2.RIGHT * 300
		$TargetPointer.visible = true
	else:
		inputDevice = inputType.KEYBOARD
		
	global_position = find_parent("Level*").find_child("TeleportIn").global_position
	$CharacterImage.play("IdleEast")
	visible = true
	$TargetPointer.visible = false
	
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
func _process(delta):
	Globals.heroPosition = position
#+
# Class specific methods
#-
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
		var weapon = Preloaded.heroPWeaponScene.instantiate()
#		weapon.position = pos
#		weapon.direction = dir
#		weapon.rotation = rot
#		level.get_node("Weapons").add_child(weapon)

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
		to = level.get_node("Hero").get_node("TargetPointer")
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

# Make us visible
func spawn() -> void:	
	$CharacterImage/AnimationPlayer.play("FadeFromBlack")


#+
# Signal callbacks
#-

func _on_spawn_timer_timeout():
	spawn()


func _on_teleport_effect_animation_finished():
	active = true
	$TargetPointer.visible = true
