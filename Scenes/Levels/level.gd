extends Mcp
class_name Level


#++
# <description>
#
#--

#+
# Properties
#-

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float
@export var levelNumber: int

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
# Scale the playing area images
# Set which level is playing
# Set WeaponsDeployed pointer
# Find out how many challengers there are
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
	
	super._ready()
	
# _process(delta)
# Called every frame
#
# Parameters
#	delta: float				Time elapsed since last call
# Return 
#	None
#==
# Check to see if we are dead
# If so, then end the game
# Check to see if all the enemies are dead
# If so, then go to next level
# Call the super
func _process(delta) -> void:
	if Globals.health <= 0:
		exitTheLevel('lose')
	if challengersLeft <= 0:
		exitTheLevel('won')	
	super._process(delta)

# Temp to exit the scene for debugging	
func _physics_process(_delta):
	checkKeyPressed()
	super._physics_process(_delta)
	
	
#+
# Class specific methods
#-

# Temp to exit the scene for debugging
func checkKeyPressed() -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_key_pressed(KEY_W):
		exitTheLevel('win')
	if Input.is_key_pressed(KEY_L):
		exitTheLevel('lose')
		

# exitTheLevel()
# Exit the level and go to the next
#
# Parameters
#	None
# Return 
#	None
#==
# If we are the last level (5) then exit to the win/lose screen
func exitTheLevel(how: String) -> void:
	match how:
		'won':
			$AnimationPlayer.play("FadeToBlackWin")
		'lose':
			$AnimationPlayer.play("FadeToBlackLose")


#+
# Signal Callbacks
#-
