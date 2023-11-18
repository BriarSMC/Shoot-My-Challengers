extends Node

#++
# This is the entry point for the game. It controls the flow of the screens and levels
# presented to the player. 
#
#--

#+
# Properties
#-
const LEVELSPATH = "res://Scenes/Levels/"
const LEVELFILENAME = "level_"
const LEVELEXTENSION = ".tscn"

# Preloaded scenes
var preloadedScenes: Array[PackedScene] =[
	preload("res://Scenes/UI/start_screen.tscn"),
	preload("res://Scenes/UI/win_screen.tscn"),
	preload("res://Scenes/UI/lose_screen.tscn"),
	preload("res://Scenes/UI/credits_screen.tscn")
]

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
