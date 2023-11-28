extends Node2D
class_name PowerUp

# This defines the parent class for an Item.

# Properties

# Designer will choose one of these types in the Inspector
# LIFE = 0, PWEAPON = 1, SWEAPON = 2, SSHIELD = 3, LSHEILD = 4
enum powerUpIs {LIFE, PWEAPON, SWEAPON, SSHIELD, LSHIELD,}

# The following properties must be set in the Inspector by the designer
@export var scaleFactor: float
@export var increaseItemCountBy: int
@export var powerUpType: powerUpIs

# The following are set based on the Inspector values

# Virtual Godot methods

# _ready()
# Called when the object is ready
#
# Paramters
#	None
# Return 
#	None
#==
# Scale our image
func _ready() -> void:
	Globals.scaleMe(self, scaleFactor)
	
# Class specific methods

# weHaveBeenCollected()
# Called by the child when a collision with the Hero is detected.
#
# Increments the appropriate counter
#
# Paramters
#	None
# Return 
#	None
#==
# Bump the appropriate counter based on our type
func weHaveBeenCollected() -> void:
	match powerUpType:
		powerUpIs.LIFE:
			Globals.health += increaseItemCountBy
		powerUpIs.PWEAPON:
			Globals.primaryWeaponCount += increaseItemCountBy
		powerUpIs.SWEAPON: 
			Globals.secondaryWeaponCount += increaseItemCountBy
		powerUpIs.SSHIELD:
			Globals.shortShieldCount += increaseItemCountBy
		powerUpIs.LSHIELD:
			Globals.longShieldCount += increaseItemCountBy

# Signal callbacks
