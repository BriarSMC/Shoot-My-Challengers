extends Node2D
class_name Mcp

# This is the entry point for the game. It controls the flow of the screens and levels
# presented to the player.

# Signals
signal fadeTheUI
signal changeGameScreen

# Properties

const LEVELSPATH = "res://Scenes/Levels/"
const LEVELFILENAME = "level_"
const LEVELEXTENSION = ".tscn"


# Game Control Scene files
var gameScenes: Array[String] =[
	"res://Scenes/UI/start_screen.tscn",
	"res://Scenes/UI/win_screen.tscn",
	"res://Scenes/UI/lose_screen.tscn",
	"res://Scenes/UI/credits_screen.tscn"
	]

# Screen control
# Start = 0, Win = 1, Lose = 2, Credits = 3, Exit = 4, Level = 5
enum screen {START, WIN, LOSE, CREDITS, EXIT, LEVEL, }

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Virtual Godot methods


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


# Class specific methods

# changeGameScreen(newState [, level])
# This is used to change UI screens & scenes or exit the game
#
# Paramters
#	newState: state				# Switch to this state
# 	level: int					# Level number to switch to
# Return
#	None
#==
# If it's a game control screen, then switch to it.
# If it's for level screen 1-5, then switch to the level screen.
# It it's for level 0, then switch to the demo screen (TODO: REMOVE THIS AT SOME POINT)
# Then it's the "You can't get there from here" clause
func changeScreen(newScreen: screen, newLevel: int = 0) -> void:
	match newScreen:
		screen.START, screen.WIN, screen.LOSE, screen.CREDITS:
			get_tree().change_scene_to_file(gameScenes[newScreen])
		screen.LEVEL:
			if newLevel > 0:
				get_tree().change_scene_to_file(
					LEVELSPATH + LEVELFILENAME + str(newLevel) + LEVELEXTENSION)
			else:
				get_tree().change_scene_to_file("res://Scenes/scene_demo.tscn")
		_:
			print('Invalid state value for Mcp.changeGameScreen')


# Signal callbacks
