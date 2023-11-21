extends Node

#++
# This is the entry point for the game. It controls the flow of the screens and levels
# presented to the player. 
#
#--

#+
# Properties
#-

signal fadeTheUI

const LEVELSPATH = "res://Scenes/Levels/"
const LEVELFILENAME = "level_"
const LEVELEXTENSION = ".tscn"

var level: Node 

# Preloaded scenes
var preloadedScenes: Array[PackedScene] =[
	preload("res://Scenes/UI/start_screen.tscn"),
	preload("res://Scenes/UI/win_screen.tscn"),
	preload("res://Scenes/UI/lose_screen.tscn"),
	preload("res://Scenes/UI/credits_screen.tscn")
	]
var heroPWeaponScene: PackedScene = preload("res://Scenes/Weapons/hero_p_weapon.tscn")
var heroSWeaponScene: PackedScene = preload("res://Scenes/Weapons/bomb.tscn")

# State control
# Start = 0, Win = 1, Lose = 2, Credits = 3, Exit = 4, Level = 5
enum state {START, WIN, LOSE, CREDITS, EXIT, LEVEL }

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

#+
# Virtual Godot methods
#-

#func _ready() -> void:
#	pass
	


#+
# Class specific methods
#-

# changeGameState(newState [, level])
# This is used to change UI screens & scenes or exit the game
#
# Paramters
#	newState: state				# Switch to this state
# 	level: int					# Level number to switch to
# Return 
#	None
#==
# What the code is doing (steps)
func changeGameState(newState: state, level: int = 0) -> void:
	print('MCP.changeGameState: state=', newState, '  level=', level)
	match newState:
		state.START, state.WIN, state.LOSE, state.CREDITS:
			print("Changing to ", newState)
			var e = get_tree().change_scene_to_packed(preloadedScenes[newState])
			print(e)
		state.LEVEL:
			if level > 0:
				get_tree().change_scene_to_file(
					LEVELSPATH + LEVELFILENAME + str(level) + LEVELEXTENSION)
			else:
				get_tree().change_scene_to_file("res://Scenes/scene_demo.tscn")
		_: 
			print('Invalid state value for MCP.ChangeGameState')
			
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
					
# fireHeroPWeapon(pos, dir, rot)
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
func fireHeroPWeapon(pos: Vector2, dir: Vector2, rot: float) -> void:
		var weapon = heroPWeaponScene.instantiate()
		weapon.position = pos
		weapon.direction = dir
		weapon.rotation = rot
		level.get_node("Weapons").add_child(weapon)
