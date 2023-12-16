extends Mcp
class_name Level


# This is the parent class for all levels

# Properties

var powerupSpawner: PowerupSpawner
var skullArena: Marker2D
var exitLevel: bool = false
var heroDieCalled: bool = false
var isHeroDeathFinished: bool = false

@onready var hero: Hero = find_child("Hero")

# Load the game play UI
@onready var gamePlayUIScene: PackedScene = preload("res://Scenes/Levels/game_play_ui.tscn")
@onready var powerupSpawnerScene: PackedScene = preload("res://Scenes/Levels/powerup_spawner.tscn")

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float
@export var levelNumber: int
@export var arenaRadius: int = 200
@export var arenaColor: Color = Color(1,0,0,.3)


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
# Scale the playing area images
# Set which level is playing
# Connect to the SkullOfDeath's death signal
# Set WeaponsDeployed pointer
# Find out how many challengers there are
# Create the game play UI
# Save the GamePlayUI labels then update UI
# Set the randomizer
# Startup the powerup spawner
# Save location of the Skull Arena
# Play our music
func _ready() -> void:
	Globals.scaleMe($PlayingArea, scaleFactor)		# Adjust how big we are
	Globals.currentLevel =  self
	Globals.currentLevelNdx = levelNumber

	find_child("SkullOfDeath").connect("levelOver", levelOver)

	var n: Node2D = Node2D.new()
	n.set('name', 'WeaponsDeployed')
	add_child(n)
	Globals.weaponsDeployed = n

	Globals.challengersLeft = find_child("Challengers").get_child_count()

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

	skullArena = find_child('SkullArena')

	MusicHandler.playPrimary(MusicHandler.MUSIC.LEVELS)
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
# NOTE: Easier said than done. Didn't want to use signals for this.
#		So, heroDieCalled is a switch so that we only execute this chunk of
#		code once. Set the switch so we don't execute this again. Then
#		kill any outstanding SFX players. Apparently, this is done asynchonously.
#		So, we need to make sure all the outstanding SFX players are gone before
#		we can play our death sound. Hence the while loop.
# 	NOTE 2: Hero class handles the Hero's die() method. Character class only handles
# 	Challengers die() routines.
# Check to see if all the enemies are dead
# If so, then go to next level
func _process(delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if Globals.health <= 0:
		if not heroDieCalled:
			heroDieCalled = true
			SfxHandler.killAll()
			inactivateChallengers()
			while Globals.sfxNode.get_child_count() > 0: await get_tree().create_timer(0.1).timeout
			hero.connect("HeroDeathFinished", heroDeathFinished)
			hero.die()
			if isHeroDeathFinished:
				exitTheLevel('lose')
			return

	if exitLevel:
		if levelNumber >= 5:
			exitTheLevel('won')
		else:
			exitTheLevel('next')
		return

# _draw()
# Called when any drawing needs to be done
#
# Parameters
#		None
# Return
#		None
#==
# Draw a circle for the Skull Arena
# NOTE: Child must call super._ready() if it defines own _ready() method
func _draw() -> void:
	draw_circle(skullArena.position, arenaRadius, arenaColor) #Color(.8, .68, 0, .2))

# Class specific methods


# inactivateChallengers()
# Set all challengers active to false
#
# Parameters
#		None
# Return
#		None
#==
# Find all the remaining challengers
# Turn the active switch off
func inactivateChallengers() -> void:
	var challengers = find_child("Challengers").find_children("*")
	for c in challengers:
		if c.is_in_group("Challenger"): c.call("setActive", false)   #active = false

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
		'next':	$AnimationPlayer.play('FadeToBlack')
		'won':	$AnimationPlayer.play("FadeToBlackWin")
		'lose':	$AnimationPlayer.play("FadeToBlackLose")

# Signal Callbacks

# Catch when hero death theatrics are finished
func heroDeathFinished() -> void:
	isHeroDeathFinished = true

# levelOver()
# Indicate the level is over
#
# Parameters
#		None
# Return
#		None
#==
# What the code is doing (steps)
func levelOver() -> void:
	exitLevel = true
