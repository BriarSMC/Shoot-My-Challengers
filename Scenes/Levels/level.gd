extends Mcp
class_name Level


# This is the parent class for all levels

# Properties

var powerupSpawner: PowerupSpawner

# Load the game play UI
@onready var gamePlayUIScene: PackedScene = preload("res://Scenes/Levels/game_play_ui.tscn")
@onready var powerupSpawnerScene: PackedScene = preload("res://Scenes/Levels/powerup_spawner.tscn")

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float
@export var levelNumber: int
@export var arenaRadius: int = 200


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
# Connect to the updateUIValues signal (In Globals)
# Scale the playing area images
# Set which level is playing
# Set WeaponsDeployed pointer
# Find out how many challengers there are
# Create the game play UI
# Save the GamePlayUI labels then update UI
# Set the randomizer
# Startup the powerup spawner
func _ready() -> void:
	Globals.scaleMe($PlayingArea, scaleFactor)		# Adjust how big we are
	Globals.currentLevel =  self
	Globals.currentLevelNdx = levelNumber

	var n: Node2D = Node2D.new()
	n.set('name', 'WeaponsDeployed')
	add_child(n)
	Globals.weaponsDeployed = n

	challengersLeft = find_child("Challengers").get_child_count()
	Globals.challengersDefeated = 0

	var gamePlayUI: Object = gamePlayUIScene.instantiate()
	add_child(gamePlayUI)
	gamePlayUI.updateUI()

	# Besure to set trueRandom to true in the Inspector before deploy
	if Globals.trueRandom:
		randomize()
	else:
		seed(8675309)

	powerupSpawner = powerupSpawnerScene.instantiate()
	add_child(powerupSpawner)

	super._ready()

# _process(delta)
# Called every frame
#
# Parameters
#	delta: float				Time elapsed since last call
# Return
#	None
#==
# Check to see if player wants to quit the game
# Check to see if we are dead
# If so, then end the game
# Check to see if all the enemies are dead
# If so, then go to next level
# Call the super
func _process(delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Globals.health <= 0:
		exitTheLevel('lose')
	if challengersLeft <= 0:
		exitTheLevel('won')
	super._process(delta)


# Class specific methods

# exitTheLevel()
# Exit the level and go to the next
#
# Parameters
#		None
# Return
#		None
#==
# If we are the last level (5) then exit to the win/lose screen
func exitTheLevel(how: String) -> void:
	match how:
		'won':
			$AnimationPlayer.play("FadeToBlackWin")
		'lose':
			$AnimationPlayer.play("FadeToBlackLose")

# Signal Callbacks
