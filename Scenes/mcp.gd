extends Node2D
class_name Mcp

#++
# This is the entry point for the game. It controls the flow of the screens and levels
# presented to the player. 
#
#--

#+
# Properties
#-

signal fadeTheUI
signal changeGameScreen

const LEVELSPATH = "res://Scenes/Levels/"
const LEVELFILENAME = "level_"
const LEVELEXTENSION = ".tscn"

var challengersLeft: int					# Number of challengers left on level

# Game Control Scene files
var gameScenes: Array[String] =[
	"res://Scenes/UI/start_screen.tscn",
	"res://Scenes/UI/win_screen.tscn",
	"res://Scenes/UI/lose_screen.tscn",
	"res://Scenes/UI/credits_screen.tscn"
	]
var heroPWeaponScene: String = "res://Scenes/Weapons/hero_p_weapon.tscn"
var heroSWeaponScene: String = "res://Scenes/Weapons/bomb.tscn"

# Screen control
# Start = 0, Win = 1, Lose = 2, Credits = 3, Exit = 4, Level = 5
enum screen {START, WIN, LOSE, CREDITS, EXIT, LEVEL, }

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
# Set up changing to next game screen
# Detect what kind of input device the player is using
# Hide the mouse pointer if it's a game controller
func _ready() -> void:
	connect("changeGameScreen", changeScreen)
	if Input.get_connected_joypads().size() > 0:
		Globals.inputDevice = Globals.inputType.GAMECONTROLLER
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Globals.inputDevice = Globals.inputType.KEYBOARD

# _process(delta)
# Called every frame
#
# Parameters
#	delta: float				Elapsed time since last call
# Return 
#	None
#==
# What the code is doing (steps)
func _process(_delta) -> void:
	pass

# _physics_process(delta)
# Called every frame
#
# Parameters
#	delta: float				Elapsed time since last call
# Return 
#	None
#==
# What the code is doing (steps)
func _physics_process(_delta) -> void:
	pass
	
	
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
func changeScreen(newScreen: screen, newLevel: int = 0) -> void:
	print('changeScreen: screen=', newScreen, '  newLevel=', newLevel)
	match newScreen:
		screen.START, screen.WIN, screen.LOSE, screen.CREDITS:
			print("Changing to ", newScreen)
#			get_tree().change_scene_to_packed(Preloaded.preloadedScenes[newScreen])
			get_tree().change_scene_to_file(gameScenes[newScreen])
		screen.LEVEL:
			if newLevel > 0:
				print('Changing to level ', newLevel)
				get_tree().change_scene_to_file(
					LEVELSPATH + LEVELFILENAME + str(newLevel) + LEVELEXTENSION)
			else:
				get_tree().change_scene_to_file("res://Scenes/scene_demo.tscn")
		_: 
			print('Invalid state value for Mcp.ChangeGameState')
			

