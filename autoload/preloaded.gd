extends Node

#++
# This autoload file contains all of our preloaded files
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer

# The following are set based on the Inspector values

# Preloaded scenes
var preloadedScenes: Array[PackedScene] =[
	preload("res://Scenes/UI/start_screen.tscn"),
	preload("res://Scenes/UI/win_screen.tscn"),
	preload("res://Scenes/UI/lose_screen.tscn"),
	preload("res://Scenes/UI/credits_screen.tscn")
	]
var heroPWeaponScene: PackedScene = preload("res://Scenes/Weapons/hero_p_weapon.tscn")
var heroSWeaponScene: PackedScene = preload("res://Scenes/Weapons/bomb.tscn")
